//
//  GuideUpcomingBookingsPage.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import SwiftUI

struct GuideUpcomingBookingsPage: View {

    @State var presenter: GuideUpcomingBookingsPresenter

    var header: some View {
        HStack {
            Spacer()
            VStack {
                Text(presenter.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                NavigationLink(destination: UpdateProfilePage().environmentObject(presenter)) {
                    Text("Edit Profile")
                        .font(.headline)
                }
            }
            DashboardProfileImage<GuideEarningsPresenter>()
                .frame(height: 130)
                .padding()
                .shadow(color: .black, radius: 4, x: 3, y: 4)
        }.padding(.horizontal, 30)
    }

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
        PageLayout(headerContent: AnyView(header)) { geometry in
            makeContent(geometry)
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
        }.onAppear {
            presenter.refresh()
        }
    }
}
