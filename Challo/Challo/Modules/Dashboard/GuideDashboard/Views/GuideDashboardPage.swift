//
//  GuideDashboardPage.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import SwiftUI

struct GuideDashboardPage: View {

    @EnvironmentObject var presenter: GuideDashboardPresenter

    @ViewBuilder
    func makeContent(_ geometry: GeometryProxy) -> some View {
        VStack {
            TabSelectionView(selectedIndex: $presenter.selectedIndex,
                             options: presenter.tabTitles)

            Divider().padding(.top)

            if presenter.selectedTab == .earnings {
                presenter.earningsDashboard
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.8)
                    .padding(.vertical)
            }

            if presenter.selectedTab == .upcomingBookings {
                presenter.upcomingBookingsDashboard
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.8)
                    .padding(.vertical)
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
                NavigationLink(destination: UpdateProfilePageGuide().environmentObject(presenter)) {
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
            DashboardProfileImage(presenter: presenter)
                .frame(height: 130)
                .padding()
                .shadow(color: .black, radius: 4, x: 3, y: 4)
        }.padding(.horizontal, 30)
    }
    
    var body: some View {
        GeometryReader { _ in
            if !presenter.hasGuideOnboarded {
                presenter.router?.getOnboardingPage()
                    .environmentObject(presenter)
            } else {
                PageLayout(background: .mountainBackground, headerContent: AnyView(header)) { geo in
                    makeContent(geo)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .onAppear { presenter.onAppear() }
    }
}
