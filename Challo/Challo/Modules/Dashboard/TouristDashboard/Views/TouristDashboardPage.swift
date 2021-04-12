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

                    TabSelectionView(selectedIndex: $presenter.selectedIdx,
                                     options: presenter.tabTitles)
                    
                    if presenter.isLoading {
                        Loading(isAnimating: .constant(true), style: .large)
                    } else {
                        if presenter.selectedTab == .upcomingBookings {
                            BookingCardListingsView(
                                width: geometry.size.width,
                                emptyListMessage: "You don't have any upcoming trips",
                                bookings: $presenter.upcomingBookings)
                        }
                        
                        if presenter.selectedTab == .pastBookings {
                            BookingCardListingsView(
                                width: geometry.size.width,
                                emptyListMessage: "You don't have any past trips",
                                bookings: $presenter.pastBookings)
                        }
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
