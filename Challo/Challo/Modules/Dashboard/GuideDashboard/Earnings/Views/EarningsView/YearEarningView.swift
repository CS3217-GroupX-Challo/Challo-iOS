//
//  MonthlyEarningView.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct YearEarningView: View {

    typealias Formatter = CustomDateFormatter

    @ObservedObject private var presenter: YearEarningsPresenter

    init(superPresenter: GuideEarningsPresenter) {
        presenter = superPresenter.yearSubPresenter
    }

    var body: some View {
        VStack {
            if presenter.loading {
                Loading(isAnimating: .constant(true), style: .large)
            } else {
                Card {
                    Text("Total earnings of the year:")

                    Text("$\(presenter.totalEarnings, specifier: "%.2f")")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16).stroke(Color.themeSecondary)
                        )

                }

                Divider()

                BarChart(axisLabels: presenter.dateRange
                            .map { Formatter.displayDateWithCustomFormat($0, template: "MMM") },
                         data: presenter.history)
                    .frame(maxWidth: .infinity)
            }

        }
        .padding()
        .onAppear { presenter.refresh() }
    }
}
