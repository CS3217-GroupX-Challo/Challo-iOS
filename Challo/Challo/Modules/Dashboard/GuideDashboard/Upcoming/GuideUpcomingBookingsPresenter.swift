//
//  GuideUpcomingBookingsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation

class GuideUpcomingBookingsPresenter: PresenterProtocol {

    var interactor: GuideUpcomingBookingsInteractor!
    var router: GuideUpcomingBookingsRouter?

    let userState: UserStateProtocol

    @Published var loading = true

    @Published var upcomingBookings: [Booking] = []

    @Published var name: String

    init(userState: UserStateProtocol) {
        self.userState = userState
        self.name = userState.name
    }

    func didPopulateBookings(bookings: [Booking]) {
        upcomingBookings = bookings.filter { $0.status != .Completed }
        loading = false
    }

    func refresh() {
        name = userState.name
        interactor.populateBookings()
    }
}
