//
//  EarningViewNavigation.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct EarningViewNavigation: View {

    var presenter: GuideEarningsPresenter

    var body: some View {

        NavigationView {
            List {
                NavigationLink(
                    destination: WeekEarningsView(superPresenter: presenter),
                    label: {
                        Text("Week view")
                    })
                NavigationLink(
                    destination: YearEarningView(superPresenter: presenter),
                    label: {
                        Text("Year view")
                    })
                NavigationLink(
                    destination: BookingHistoryView(superPresenter: presenter),
                    label: {
                        Text("View booking history")
                    })
            }
            .listStyle(SidebarListStyle())
        }

    }
}
