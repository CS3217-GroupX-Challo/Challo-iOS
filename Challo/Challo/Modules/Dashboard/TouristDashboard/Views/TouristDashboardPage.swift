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
                VStack {
                    Spacer()
                    Loading(isAnimating: .constant(true), style: .large)
                    Spacer()
                }
            } else {
                if presenter.selectedTab == .upcomingBookings {
                    BookingCardListingsView(
                        width: geometry.size.width,
                        emptyListMessage: "You don't have any upcoming trips",
                        bookings: $presenter.upcomingBookings,
                        isRefreshing: $presenter.isRefreshing)
                }
                
                if presenter.selectedTab == .pastBookings {
                    BookingCardListingsView(
                        width: geometry.size.width,
                        emptyListMessage: "You don't have any past trips",
                        bookings: $presenter.pastBookings,
                        isRefreshing: $presenter.isRefreshing) { booking, width in
                        AnyView(PastBookingCard(booking: booking, width: width))
                    }
                }
            }
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 15) {
                Text(presenter.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                NavigationLink(destination: UpdateProfilePage().environmentObject(presenter)) {
                    HStack(spacing: 5) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(Color(.systemGray))
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundColor(Color(.systemGray))
                    }
                }
            }
            DashboardProfileImage()
                .frame(height: 130)
                .padding()
                .shadow(color: .black, radius: 4, x: 3, y: 4)
        }.padding(.horizontal, 30)
    }
    
    var body: some View {
        PageLayout(background: .mountainBackground, headerContent: AnyView(header)) { geometry in
            makeContent(geometry)
                .frame(maxWidth: .infinity)
        }.onAppear {
            presenter.refresh()
        }
    }
}
