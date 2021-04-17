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

    var body: some View {
        ScrollView(showsIndicators: false) {
            if bookings.isEmpty {
                Text(emptyListMessage)
                    .foregroundColor(.themeForeground)
                    .padding()
            } else {
                bookingList.padding()
            }
        }
    }

    private var bookingList: some View {
        VStack {
            ForEach(bookings.indices) { index in
                bookingCard(at: index)
            }
        }
    }

    private func bookingCard(at index: Int) -> AnyView {
        let booking = bookings[index]
        switch pov {
        case .guide:
            return AnyView(guidePOVBookingCard(booking: booking))
        case .tourist:
            return AnyView(touristPOVBookingCard(booking: booking))
        }
    }

    private func guidePOVBookingCard(booking: Booking) -> some View {
        let tourist = booking.tourist
        let chatView = ContactTouristPage(tourist: tourist)
        return BookingCard(booking: booking,
                           width: width / 2,
                           chatPartner: tourist,
                           chatView: chatView,
                           contactMessage: "Contact Tourist")
    }

    private func touristPOVBookingCard(booking: Booking) -> some View {
        let guide = booking.guide
        let chatView = ContactGuidePage(guide: guide)
        return BookingCard(booking: booking,
                           width: width / 2,
                           chatPartner: guide,
                           chatView: chatView,
                           contactMessage: "Contact Guide")
    }

    enum PointOfView: String {
        case guide, tourist
    }
}
