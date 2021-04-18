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

            switch presenter.selectedTab {
            case .weeklyView:
                WeekEarningsView(superPresenter: presenter)
                    .padding()
            case .yearlyView:
                YearEarningView(superPresenter: presenter)
                    .padding()
            case .bookingHistory:
                BookingHistoryView(superPresenter: presenter)
                    .padding()
            }
        }
        .padding()
    }

}
