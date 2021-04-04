//
//  TripCard.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct BookingCard: View {

    var booking: Booking
    var width: CGFloat
    
    var body: some View {
        Card {
            Image.mountainBackground
                .resizable()
                .scaledToFit()
                .frame(width: width * 4 / 5)
                .cornerRadius(10)
                .padding(10)
            Text(booking.trail.title)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .bold()
            HStack {
                Text(booking.date, style: .date)
            }
            .foregroundColor(.themeForeground)
            .font(.caption)
            Text("Guide: \(booking.guide.name ?? "Challo Naveen")")
        }
        .frame(width: width,
               alignment: .center)
    }
}
