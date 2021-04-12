//
//  BookingDetails.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct BookingDetailsView: View, CustomLabelMaker {

    var width: CGFloat
    var height: CGFloat
    var booking: Booking

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
