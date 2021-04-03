//
//  EarningViewNavigation.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct EarningViewNavigation: View {

    var presenter: GuideDashboardPresenter

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: WeekEarningsView(superPresenter: presenter),
                    label: {
                        Card {
                            Text("Week")
                                .rotationEffect(Angle(radians: -Double.pi / 2))
                        }
                    })

                NavigationLink(
                    destination: YearEarningView(superPresenter: presenter),
                    label: {
                        Card {
                            Text("Month")
                                .rotationEffect(Angle(radians: -Double.pi / 2))

                        }
                    })
            }

        }
        .padding()
    }
}
