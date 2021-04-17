//
//  GuideDashboardPage.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import SwiftUI

struct GuideEarningsPage: View {

    @ObservedObject var presenter: GuideEarningsPresenter

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
            DashboardProfileImage<GuideEarningsPresenter>().environmentObject(presenter)
                .frame(height: 130)
                .padding()
                .shadow(color: .black, radius: 4, x: 3, y: 4)
        }.padding(.horizontal, 30)
    }

    var content: some View {
        GeometryReader { _ in
            VStack {
                Text("Earnings")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 40)

                EarningViewNavigation(presenter: presenter)
            }
        }
    }

    var body: some View {
        PageLayout(headerContent: AnyView(header)) { _ in
            content
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
        }
    }

}
