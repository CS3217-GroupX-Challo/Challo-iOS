//
//  WeeklyEarningsView.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct WeekEarningsView: View {

    typealias Formatter = CustomDateFormatter

    @ObservedObject private var presenter: WeekEarningsPresenter

    init(superPresenter: GuideDashboardPresenter) {
        presenter = superPresenter.weekSubPresenter
    }

    var body: some View {
        VStack {
            if presenter.loading {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                Card {
                    Text("Total earnings of the week:")

                    Text("$\(presenter.totalEarnings, specifier: "%.2f")")
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

        }
        .padding()
        .onAppear { presenter.refresh() }
    }
}
