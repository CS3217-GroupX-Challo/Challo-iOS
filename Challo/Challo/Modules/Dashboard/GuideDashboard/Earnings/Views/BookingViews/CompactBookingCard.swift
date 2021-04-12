//
//  CompactBookingCard.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation
import SwiftUI

struct CompactBookingCard: View {

    @EnvironmentObject var presenter: GuideEarningsPresenter

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
                .frame(maxWidth: width / 4, maxHeight: 50)
        }.frame(width: width / 3)
    }

    var body: some View {
        Card {
            HStack(alignment: .top) {
                makeDetail(image: "leaf",
                           label: booking.trail.title)
                makeDetail(image: "calendar",
                           label: CustomDateFormatter.displayFriendlyDate(booking.date))
                makeDetail(image: "person.crop.circle",
                           label: booking.tourist.name ?? "")
                makeDetail(image: "dollarsign.circle",
                           label: "\(booking.fee)")
            }
        }
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .background(Color.clear)
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
        )
        .frame(width: width,
               alignment: .center)
        .padding()

    }
}
