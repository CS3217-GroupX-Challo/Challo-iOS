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
        
        return AnyView(BookingCard(booking: booking, width: width) { })
    }
}
