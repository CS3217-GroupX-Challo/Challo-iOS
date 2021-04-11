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
    @Binding var bookings: [Booking]

    var body: some View {
        ScrollView(showsIndicators: false) {
            if bookings.isEmpty {
                Text(emptyListMessage)
                    .foregroundColor(.themeForeground)
                    .padding()
            } else {
                VStack {
                    ForEach(bookings.indices) { index in
                        BookingCard(booking: bookings[index], width: width / 2)
                    }
                }.padding()
            }
        }
    }
}
