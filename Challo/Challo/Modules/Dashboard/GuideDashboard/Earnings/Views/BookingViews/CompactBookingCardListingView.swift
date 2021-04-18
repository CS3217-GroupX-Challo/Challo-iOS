//
//  CompactBookingCardListingView.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation
import SwiftUI

struct CompactBookingCardListingView: View {
    let emptyListMessage = "You haven't been booked before!"

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
                        CompactBookingCard(booking: bookings[index], width: width / 2)
                    }
                }.padding()
            }
        }
    }
    
}
