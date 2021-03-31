//
//  TripCardListingsView.swift
//  Challo
//
//  Created by Tan Le Yang on 27/3/21.
//

import SwiftUI

struct BookingCardListingsView: View {

    var width: CGFloat
    @Binding var bookings: [Booking]

    var body: some View {
        ScrollView(showsIndicators: true) {
            if bookings.isEmpty {
                Text("You don't have any upcoming trips")
                    .foregroundColor(.themeForeground)
                    .padding()
            } else {
                VStack {
                    ForEach(bookings.indices) { index in
                        BookingCard(booking: bookings[index], width: width)
                    }
                }
            }
        }
    }
}
