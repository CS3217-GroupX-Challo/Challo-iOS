//
//  BookingRepository.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class BookingRepository: Repository<UUID, Booking>, BookingRepositoryProtocol {

    let bookingAPI: BookingAPIProtocol

    init(bookingAPI: BookingAPIProtocol) {
        self.bookingAPI = bookingAPI
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
}
