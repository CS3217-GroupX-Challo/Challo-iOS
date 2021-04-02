//
//  WeeklyEarningsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 2/4/21.
//

import SwiftUI

class WeeklyEarningsPresenter: EarningSubPresenter {

    weak var interactor: GuideDashboardInteractor!

    @Published var earningsOfWeek = 0.0
    @Published var history = [Double]()
    @Published var dateRange = Calendar.current.daysInCurrentWeek

    func didPopulateBookings(bookings: [Booking]) {
        let completedBookings = bookings.filter { $0.status == .Completed }
        dateRange.forEach { date in
            let earningsOnDate = completedBookings
                .filter { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }
                .reduce(0.0, { $0 + $1.fee })
            history.append(earningsOnDate)
        }
        earningsOfWeek = history.reduce(0, { $0 + $1 })
    }

}
