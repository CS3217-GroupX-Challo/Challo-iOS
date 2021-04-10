//
//  DashboardPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct TouristDashboardPage: View {
    
    @EnvironmentObject var presenter: TouristDashboardPresenter
    @State private var selectedIdx = 0

    var body: some View {
        VStack {
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

                    TabSelectionView(selectedIndex: $selectedIdx,
                                     options: ["Upcoming bookings", "Past bookings"])
                    
                    if presenter.isLoading {
                        Loading(isAnimating: .constant(true), style: .large)
                    } else {
                        BookingCardListingsView(
                            width: geometry.size.width,
                            emptyListMessage: "You don't have any upcoming trips",
                            bookings: $presenter.upcomingBookings)
                    }
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
