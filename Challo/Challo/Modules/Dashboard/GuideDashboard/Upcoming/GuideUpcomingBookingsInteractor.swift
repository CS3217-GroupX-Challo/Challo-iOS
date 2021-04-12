//
//  GuideUpcomingBookingsInteractor.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation

class GuideUpcomingBookingsInteractor: InteractorProtocol {

    weak var presenter: GuideUpcomingBookingsPresenter!

    let userState: UserStateProtocol
    let bookingRepository: BookingRepositoryProtocol

    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
    }

    func populateBookings() {
        guard let id = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForGuideAndRefresh(id: id,
                                                         didRefresh: presenter.didPopulateBookings(bookings:))
    }
    
}
