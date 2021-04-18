//
//  EarningViewNavigation.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct EarningViewNavigation: View {

    @ObservedObject var presenter: GuideEarningsPresenter

    var body: some View {
        VStack {
            TabSelectionView(selectedIndex: $presenter.selectedIndex, options: presenter.tabTitles)

            switch presenter.selectedTab {
            case .weeklyView:
                WeekEarningsView(superPresenter: presenter)
            case .yearlyView:
                YearEarningView(superPresenter: presenter)
            case .bookingHistory:
                BookingHistoryView(superPresenter: presenter)
            }
        }
        .padding()
    }
}
