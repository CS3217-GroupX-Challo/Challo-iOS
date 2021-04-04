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

    func makeDetail(image: String, label: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: width / 12)
                .padding(.bottom, 5)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .frame(maxWidth: width / 4)
        }.frame(width: width / 3)
    }
    
    var body: some View {
        Card {
            Image.mountainBackground
                .resizable()
                .scaledToFit()
                .frame(width: width * 7 / 8)
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
            HStack(alignment: .top) {
                makeDetail(image: "leaf",
                           label: booking.trail.title)
                makeDetail(image: "calendar",
                           label: CustomDateFormatter.displayFriendlyDate(booking.date))
                makeDetail(image: "person.crop.circle",
                           label: booking.guide.name ?? "")
            }
        }.cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .background(Color.clear)
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
        )
        .frame(width: width,
               alignment: .center)
        
    }
}
