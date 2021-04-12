//
//  BookingDetails.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct BookingDetailsView: View {

    var width: CGFloat
    var height: CGFloat
    var booking: Booking

    func makeDetail(image: String, label: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: width / 10)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .frame(maxWidth: width / 2, maxHeight: 50)
        }
        .frame(maxHeight: height * 0.2)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TrailGuideSelectionCard(guide: booking.guide,
                                        width: width * 0.5,
                                        height: height,
                                        selected: false)
                VStack {
                    makeDetail(image: "leaf",
                               label: booking.trail.title)
                    makeDetail(image: "calendar",
                               label: CustomDateFormatter.displayFriendlyDate(booking.date))
                    makeDetail(image: "dollarsign.circle",
                               label: "\(String(format: "%.2f", booking.fee))Rp")
                }
                .padding()
            }
        }
        .padding()
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}
