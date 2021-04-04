//
//  TripCardListingsView.swift
//  Challo
//
//  Created by Tan Le Yang on 27/3/21.
//

import SwiftUI

struct BookingCardListingsView: View {

    var width: CGFloat
    var emptyListMessage: String
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
