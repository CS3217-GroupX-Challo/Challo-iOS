//
//  MockBookingRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
@testable import Challo

class MockBookingRepository: Repository<UUID, Booking>, BookingRepositoryProtocol {

    let bookingAPI: BookingAPIProtocol

    init() {
        self.bookingAPI = MockBookingAPI()
    }

    private func refreshBookings(_ bookings: [Booking]) {
        for booking in bookings {
            upsert(entity: booking, key: booking.bookingId)
        }
    }

    func fetchBookingForTouristAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?) {
        bookingAPI.getBookingsForTourist(id: id) { [weak self] bookings in
            self?.refreshBookings(bookings)
            didRefresh?(bookings)
        }
    }

    func fetchBookingForGuideAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?) {
        bookingAPI.getBookingsForGuide(id: id) { [weak self] bookings in
            self?.refreshBookings(bookings)
            didRefresh?(bookings)
        }
    }

    func initialFetch(type user: BookingUser, userId: UUID, didFetch: @escaping (([Booking]) -> Void)) {
        if user == .guide {
            fetchBookingForGuideAndRefresh(id: userId, didRefresh: didFetch)
        } else {
            fetchBookingForTouristAndRefresh(id: userId, didRefresh: didFetch)
        }
    }
}
