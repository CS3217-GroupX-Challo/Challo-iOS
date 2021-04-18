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

    var body: some View {
        BookingCardLayout(width: width) {
            Card {
                HStack(alignment: .top) {
                    let imageWidth = width / 4
                    LabeledImage(imageName: "leaf",
                                 label: booking.trail.title,
                                 textWidth: imageWidth)
                        .frame(width: width / 3)
                    LabeledImage(imageName: "calendar",
                                 label: CustomDateFormatter.displayFriendlyDate(booking.date),
                                 textWidth: imageWidth)
                        .frame(width: width / 3)
                    LabeledImage(imageName: "person.crop.circle",
                                 label: booking.tourist.name ?? "",
                                 textWidth: imageWidth)
                        .frame(width: width / 3)
                    LabeledImage(imageName: "dollarsign.circle",
                                 label: "\(booking.fee)",
                                 textWidth: imageWidth)
                        .frame(width: width / 3)
                }
            }
        }
    }
}
