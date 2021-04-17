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
    @Binding var isRefreshing: Bool
    var createBookingCard: ((Booking, CGFloat) -> AnyView)?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
   ]
    
    var body: some View {
        RefreshableScrollView(refreshing: $isRefreshing) {
            if bookings.isEmpty {
                Text(emptyListMessage)
                    .foregroundColor(.themeForeground)
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(bookings.indices) { index in
                        GeometryReader { geometry in
                            constructBookingCard(booking: bookings[index], width: geometry.size.width * 0.9)
                        }.frame(minHeight: 450)
                    }
                }.padding()
            }
        }.padding(.bottom, 100)
    }

    private func constructBookingCard(booking: Booking, width: CGFloat) -> AnyView {
        if let constructor = createBookingCard {
            return constructor(booking, width)
        }
        
        return AnyView(BookingCard(booking: booking, width: width) { })
    }
}
