//
//  WeeklyEarningsView.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct WeekEarningsView: View {

    typealias Formatter = CustomDateFormatter

    private var presenter: WeekEarningsPresenter

    init(superPresenter: GuideDashboardPresenter) {
        presenter = superPresenter.weekSubPresenter
        presenter.refresh()
    }

    var body: some View {
        VStack {
            Card {
                Text("Total earnings of the week:")

                Text("$\(presenter.earningsOfWeek, specifier: "%.2f")")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16).stroke(Color.themeSecondary)
                    )

            }

            Divider()

            BarChart(axisLabels: presenter.dateRange
                        .map { Formatter.displayDateWithCustomFormat($0, template: "EEE") },
                     data: presenter.history)

        }
        .padding()
        .onAppear { presenter.refresh() }
    }
}
