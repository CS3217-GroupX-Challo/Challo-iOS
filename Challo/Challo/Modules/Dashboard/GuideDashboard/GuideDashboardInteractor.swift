//
//  GuideDashboardInteractor.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideDashboardInteractor: InteractorProtocol {

    weak var presenter: GuideDashboardPresenter!

    let bookingRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol!

    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol) {
        self.bookingRepository = bookingRepository
        self.userState = userState
    }

    func populateBookings(callback: @escaping ([Booking]) -> Void) {
        guard let uuid = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForGuideAndRefresh(id: uuid, didRefresh: callback)
    }

}
