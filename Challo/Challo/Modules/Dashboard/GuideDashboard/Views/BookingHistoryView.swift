//
//  BookingHistoryView.swift
//  Challo
//
//  Created by Ying Gao on 4/4/21.
//

import SwiftUI

struct BookingHistoryView: View {

    @ObservedObject private var presenter: GuideBookingHistorySubPresenter

    init(superPresenter: GuideDashboardPresenter) {
        presenter = superPresenter.bookingHistorySubPresenter
    }

    var body: some View {

        GeometryReader { geometry in
            VStack {
                if presenter.loading {
                    Loading(isAnimating: .constant(true), style: .large)
                } else {
                    Card {
                        Text("Total lifetime earnings:")

                        Text("$\(presenter.totalEarnings, specifier: "%.2f")")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(Color.themeSecondary)
                            )
                    }

                    Divider()

                    Text("Completed bookings")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 40)

                    BookingCardListingsView(width: geometry.size.width,
                                            emptyListMessage: "You haven't been booked before!",
                                            bookings: $presenter.completedBookings)
                }
            }
            .padding()

        }
        .onAppear { presenter.refresh() }
    }
}
