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

    @ViewBuilder
    func makeContent(_ geometry: GeometryProxy) -> some View {
        VStack {
            
            TabSelectionView(selectedIndex: $presenter.selectedIdx,
                             options: presenter.tabTitles)
            
            if presenter.isLoading {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                if presenter.selectedTab == .upcomingBookings {
                    BookingCardListingsView(
                        width: geometry.size.width,
                        pov: .tourist,
                        bookings: $presenter.upcomingBookings)
                }
                
                if presenter.selectedTab == .pastBookings {
                    BookingCardListingsView(
                        width: geometry.size.width,
                        pov: .tourist,
                        bookings: $presenter.pastBookings) { booking, width in
                        AnyView(PastBookingCard(booking: booking, width: width))
                    }
                }
            }
        }
    }
    
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
            DashboardProfileImage<TouristDashboardPresenter>()
                .frame(height: 130)
                .padding()
                .shadow(color: .black, radius: 4, x: 3, y: 4)
        }.padding(.horizontal, 30)
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
