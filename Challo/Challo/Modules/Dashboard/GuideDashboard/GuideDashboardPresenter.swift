//
//  GuideDashboardPresenter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideDashboardPresenter: PresenterProtocol {

    var router: GuideDashboardRouter?
    var interactor: GuideDashboardInteractor!

    unowned let userState: UserStateProtocol!

    @Published var totalEarnings = 0.0

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func refresh() {
        interactor.populateBookings(callback: updateTotalEarnings(bookings:))
    }

    func updateTotalEarnings(bookings: [Booking]) {
        totalEarnings = bookings.filter { $0.status == .Completed }
            .reduce(0.0, { $0 + $1.fee })
    }

}
