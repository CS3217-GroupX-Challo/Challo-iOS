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
        BookingCard(booking: booking,
                    width: width,
                    chatPartner: booking.guide,
                    chatView: ContactGuidePage(guide: booking.guide)) {
            NavigationLink(destination: presenter.getReviewPage(for: booking)) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .foregroundColor(Color.black.opacity(0.8))
                    .padding(10)
            }
        }
    }
}
