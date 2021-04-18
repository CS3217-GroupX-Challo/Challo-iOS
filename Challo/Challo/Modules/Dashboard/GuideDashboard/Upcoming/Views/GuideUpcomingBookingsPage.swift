//
//  GuideUpcomingBookingsPage.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import SwiftUI

struct GuideUpcomingBookingsPage: View {

    @State var presenter: GuideUpcomingBookingsPresenter

    @ViewBuilder
    func makeContent(_ geometry: GeometryProxy) -> some View {
        VStack {
            if presenter.loading {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                BookingCardListingsView(
                        width: geometry.size.width,
                        pov: .guide,
                        bookings: $presenter.upcomingBookings)
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            makeContent(geometry)
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
        }.onAppear {
            presenter.refresh()
        }
    }
}
