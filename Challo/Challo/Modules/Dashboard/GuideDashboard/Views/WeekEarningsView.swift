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

                Text("\(presenter.earningsOfWeek, specifier: "%.2f")")
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
