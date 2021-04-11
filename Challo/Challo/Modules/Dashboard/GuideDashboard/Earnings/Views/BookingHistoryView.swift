//
//  BookingHistoryView.swift
//  Challo
//
//  Created by Ying Gao on 4/4/21.
//

import SwiftUI

struct BookingHistoryView: View {

    @ObservedObject private var presenter: GuideBookingHistorySubPresenter

    init(superPresenter: GuideEarningsPresenter) {
        presenter = superPresenter.bookingHistorySubPresenter
    }

    var body: some View {
        GeometryReader { geometry in
            if presenter.loading {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                loadedBody(width: geometry.size.width)
                    .padding()
            }
        }
        .onAppear { presenter.refresh() }
    }

    func loadedBody(width: CGFloat) -> some View {
        VStack {
            earningsSummary

            Divider()

            Text("Completed bookings")
                .font(.title2)
                .bold()
                .padding(.leading, 40)

            CompactBookingCardListingView(width: width,
                                          bookings: $presenter.completedBookings)
        }
    }

    var earningsSummary: some View {
        Card {
            Text("Total lifetime earnings:")

            Text("$\(presenter.totalEarnings, specifier: "%.2f")")
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(Color.themeSecondary)
                )
        }
    }
}
