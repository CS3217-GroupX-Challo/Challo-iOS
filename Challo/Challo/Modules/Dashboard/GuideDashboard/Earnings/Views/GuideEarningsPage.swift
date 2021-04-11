//
//  GuideDashboardPage.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import SwiftUI

struct GuideEarningsPage: View {

    @ObservedObject var presenter: GuideEarningsPresenter

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Header(title: presenter.name,
                           subtitle: "Ready to meet new people?",
                           image: Image.mountainBackground)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.15,
                               alignment: .center)

                    Image("avatar-image")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(height: geometry.size.height * 0.10)
                        .padding()

                    Text("Earnings")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 40)

                    EarningViewNavigation(presenter: presenter)
                }
            }
        }
        .ignoresSafeArea()
    }

}
