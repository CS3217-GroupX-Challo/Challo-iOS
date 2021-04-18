//
//  PastBookingCard.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

struct PastBookingCard: View {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat
    
    var body: some View {
        BookingCard(booking: booking, width: width) {
            NavigationLink(destination: presenter.getReviewPage(for: booking)) {
                Image(systemName: "doc.append.fill")
                    .foregroundColor(Color.pink)
                    .brightness(-0.05)
                    .padding(10)
            }
        }
    }
}
