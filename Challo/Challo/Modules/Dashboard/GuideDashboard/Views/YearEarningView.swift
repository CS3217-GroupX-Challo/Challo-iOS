//
//  MonthlyEarningView.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import SwiftUI

struct YearEarningView: View {

    private var presenter: YearEarningsPresenter

    init(superPresenter: GuideDashboardPresenter) {
        presenter = superPresenter.yearSubPresenter
    }

    var body: some View {
        HStack {
            Card {

                Text("Total earnings of the year")

                Text("\(presenter.earningsOfYear, specifier: "%.2f")")
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16).stroke(Color.themeSecondary)
                    )
                    .padding()

            }

        }
        .onAppear { presenter.refresh() }
    }
}
