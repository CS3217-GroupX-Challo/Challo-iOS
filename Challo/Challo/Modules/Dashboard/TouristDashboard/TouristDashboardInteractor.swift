//
//  DashboardInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class TouristDashboardInteractor: InteractorProtocol {

    var presenter: TouristDashboardPresenter!

    let bookingsRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol!

    init(bookingsRepository: BookingRepositoryProtocol, userState: UserStateProtocol) {
        self.bookingsRepository = bookingsRepository
        self.userState = userState
    }

    func populateBookings() {
        guard let id = UUID(uuidString: userState.userId) else {
            return
        }
        bookingsRepository.fetchBookingForTouristAndRefresh(id: id, didRefresh: presenter.didPopulateBookings)
    }
}
