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

    init(superPresenter: GuideEarningsPresenter) {
        presenter = superPresenter.weekSubPresenter
    }

    var body: some View {
        VStack {
            if presenter.loading {
                VStack {
                    Spacer()
                    Loading(isAnimating: .constant(true), style: .large)
                    Spacer()
                }
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
                    .frame(maxWidth: .infinity)
            }

        }
        .padding()
        .onAppear { presenter.refresh() }
    }
}
