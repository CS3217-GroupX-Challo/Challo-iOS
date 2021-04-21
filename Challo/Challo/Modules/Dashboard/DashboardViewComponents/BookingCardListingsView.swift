//
//  TripCardListingsView.swift
//  Challo
//
//  Created by Tan Le Yang on 27/3/21.
//

import SwiftUI

struct BookingCardListingsView<Presenter: MessagingSupporter>: View {
    let emptyListMessage = "You don't have any upcoming trips"

    let presenter: Presenter

    var width: CGFloat
    var pov: PointOfView
    @Binding var bookings: [Booking]
    @Binding var isRefreshing: Bool
    var createBookingCard: ((Booking, CGFloat) -> AnyView)?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        if bookings.isEmpty {
            VStack {
                Spacer()
                Text(emptyListMessage)
                    .foregroundColor(.themeForeground)
                    .padding()
                Spacer()
            }.frame(maxHeight: .infinity)
        } else {
            RefreshableScrollView(refreshing: $isRefreshing) {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(bookings, id: \.bookingId) { booking in
                        GeometryReader { geometry in
                            constructBookingCard(booking: booking, width: geometry.size.width * 0.9)
                        }.frame(minHeight: 400)
                    }
                }.padding()
            }.padding(.bottom, 80)
        }
    }

    private func constructBookingCard(booking: Booking, width: CGFloat) -> AnyView {
        if let constructor = createBookingCard {
            return constructor(booking, width)
        }
        
        switch pov {
        case .guide:
            return AnyView(guidePOVBookingCard(booking: booking, width: width))
        case .tourist:
            return AnyView(touristPOVBookingCard(booking: booking, width: width))
        }
    }

    private func guidePOVBookingCard(booking: Booking, width: CGFloat) -> some View {
        let tourist = booking.tourist
        let chatView = ContactTouristPage(tourist: tourist).environmentObject(presenter)
        return BookingCard(booking: booking,
                           width: width,
                           chatPartner: tourist,
                           chatView: chatView) { }
    }

    private func touristPOVBookingCard(booking: Booking, width: CGFloat) -> some View {
        let guide = booking.guide
        let chatView = ContactGuidePage(guide: guide).environmentObject(presenter)
        return BookingCard(booking: booking,
                           width: width,
                           chatPartner: guide,
                           chatView: chatView) { }
    }

    enum PointOfView: String {
        case guide, tourist
    }
}
