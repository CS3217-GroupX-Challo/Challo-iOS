//
//  GuideBookingHistorySubPresenter.swift
//  Challo
//
//  Created by Ying Gao on 4/4/21.
//

import Foundation

class GuideBookingHistorySubPresenter: GuideDashboardSubPresenter {

    var interactor: GuideDashboardInteractor!

    @Published var loading = true
    @Published var totalEarnings = 0.0
    @Published var completedBookings = [Booking]() {
        didSet {
            totalEarnings = completedBookings.reduce(0.0, { $0 + $1.fee })
        }
    }

    func didPopulateBookings(bookings: [Booking]) {
        completedBookings = bookings.filter { $0.status == .Completed }
        loading = false
    }

}
