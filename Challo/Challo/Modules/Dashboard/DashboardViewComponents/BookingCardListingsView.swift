//
//  TripCardListingsView.swift
//  Challo
//
//  Created by Tan Le Yang on 27/3/21.
//

import SwiftUI

struct BookingCardListingsView: View {
    let emptyListMessage = "You don't have any upcoming trips"

    var width: CGFloat
    var pov: PointOfView
    @Binding var bookings: [Booking]
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
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(bookings.indices) { index in
                        GeometryReader { geometry in
                            constructBookingCard(booking: bookings[index], width: geometry.size.width * 0.9)
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
        let chatView = ContactTouristPage(tourist: tourist)
        return BookingCard(booking: booking,
                           width: width,
                           chatPartner: tourist,
                           chatView: chatView) { }
    }

    private func touristPOVBookingCard(booking: Booking, width: CGFloat) -> some View {
        let guide = booking.guide
        let chatView = ContactGuidePage(guide: guide)
        return BookingCard(booking: booking,
                           width: width / 2,
                           chatPartner: guide,
                           chatView: chatView) { }
    }

    enum PointOfView: String {
        case guide, tourist
    }
}
