//
//  WeeklyEarningsView.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct WeekEarningsView: View {

    private var presenter: WeekEarningsPresenter

    init(superPresenter: GuideDashboardPresenter) {
        presenter = superPresenter.weekSubPresenter
    }

    var body: some View {
        HStack {
            Card {
                Text("Total earnings of the week")

                Card {
                    Text("\(presenter.earningsOfWeek)")
                }
            }

        }
        .onAppear { presenter.refresh() }
    }
}
