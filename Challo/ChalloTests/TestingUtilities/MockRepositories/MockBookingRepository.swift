//
//  MockBookingRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
@testable import Challo

class MockBookingRepository: BookingRepository {

    init() {
        super.init(bookingAPI: MockBookingAPI())
    }

    private func refreshBookings(_ bookings: [Booking]) {
        for booking in bookings {
            upsert(entity: booking, key: booking.bookingId)
        }
    }

    override func fetchBookingForTouristAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?) {
        bookingAPI.getBookingsForTourist(id: id) { [weak self] bookings in
            self?.refreshBookings(bookings)
            didRefresh?(bookings)
        }
    }
}
