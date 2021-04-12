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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
   ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if bookings.isEmpty {
                Text(emptyListMessage)
                    .foregroundColor(.themeForeground)
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(bookings.indices) { index in
                        GeometryReader { geometry in
                            BookingCard(booking: bookings[index], width: geometry.size.width * 0.9)
                        }
                    }
                }.padding()
            }
        }
    }
}
