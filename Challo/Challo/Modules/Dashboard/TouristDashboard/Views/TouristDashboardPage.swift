//
//  DashboardPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct TouristDashboardPage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Header(title: presenter.name,
                           subtitle: "Ready to begin your journey with us?",
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

                if presenter.isLoading {
                    Loading(isAnimating: .constant(true), style: .large)
                } else {
                    BookingCardListingsView(
                        width: geometry.size.width,
                        pov: .tourist,
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
