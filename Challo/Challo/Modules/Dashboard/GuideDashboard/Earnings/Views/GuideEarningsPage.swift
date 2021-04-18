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
            TabSelectionView(selectedIndex: $presenter.selectedIndex, options: presenter.tabTitles)

            if presenter.selectedTab == .weeklyView {
                WeekEarningsView(superPresenter: presenter)
                    .padding()
            }

            if presenter.selectedTab == .yearlyView {
                YearEarningView(superPresenter: presenter)
                    .padding()
            }
            if presenter.selectedTab == .bookingHistory {
                BookingHistoryView(superPresenter: presenter)
                    .padding()
            }
        }
        .padding()
    }

}
