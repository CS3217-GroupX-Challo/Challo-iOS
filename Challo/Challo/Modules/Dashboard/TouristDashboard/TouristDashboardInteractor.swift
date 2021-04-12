//
//  DashboardInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class TouristDashboardInteractor: InteractorProtocol {

    weak var presenter: TouristDashboardPresenter!

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

// MARK: Filter and sort bookings
extension TouristDashboardInteractor {

    func sortBookings(bookings: [Booking]) -> [Booking] {
        bookings.sorted { bookingOne, bookingTwo in
            bookingOne.date < bookingTwo.date
        }
    }

    func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            ($0.status == .Paid || $0.status == .Pending) && $0.date > Date()
        }
    }

    func filterPastBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.date < Date()
        }
    }
}
