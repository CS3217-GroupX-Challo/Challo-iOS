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

    private func bookingCard(at index: Int) -> some View {
        let booking = bookings[index]
        switch pov {
        case .guide:
            return BookingCard(booking: booking, width: width / 2, chatPartner: booking.tourist)
        case .tourist:
            return BookingCard(booking: booking, width: width / 2, chatPartner: booking.guide)
        }
    }

    enum PointOfView: String {
        case guide, tourist
    }
}
