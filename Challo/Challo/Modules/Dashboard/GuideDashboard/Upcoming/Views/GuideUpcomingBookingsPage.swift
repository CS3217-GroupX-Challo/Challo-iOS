//
//  GuideUpcomingBookingsPage.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import SwiftUI

struct GuideUpcomingBookingsPage: View {

    @State var presenter: GuideUpcomingBookingsPresenter

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Header(title: presenter.name,
                           subtitle: "Your upcoming bookings",
                           image: Image.mountainBackground)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.15,
                               alignment: .center)
                    Spacer()
                }

                presenter.displayedProfileImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(height: geometry.size.height * 0.10)
                    .padding()

                Text("Upcoming bookings")
                    .font(.title2)
                    .bold()

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
        .padding(.bottom, 80)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            presenter.refresh()
        }
    }
}
