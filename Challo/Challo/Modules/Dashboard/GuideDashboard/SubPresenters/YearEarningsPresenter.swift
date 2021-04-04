//
//  MonthlyEarningsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import Foundation

class YearEarningsPresenter: EarningSubPresenter {

    var interactor: GuideDashboardInteractor!

    @Published private(set) var loading = true
    @Published var totalEarnings = 0.0
    @Published var history = [Double]()
    @Published var dateRange = Calendar.current.monthsInCurrentYear

    func didPopulateBookings(bookings: [Booking]) {
        let completedBookings = bookings.filter { $0.status == .Completed }
        dateRange.forEach { month in
            let earningsInMonth = completedBookings
                .filter { Calendar.current.isDate($0.date, equalTo: month, toGranularity: .month) }
                .reduce(0.0, { $0 + $1.fee })
            history.append(earningsInMonth)
        }
        totalEarnings = history.reduce(0.0, { $0 + $1 })
        loading = false
    }

}
