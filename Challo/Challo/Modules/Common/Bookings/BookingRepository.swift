//
//  BookingRepository.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class BookingRepository: Repository<UUID, Booking>, BookingRepositoryProtocol, LocalStorageRetriever {

    typealias Model = Booking
    typealias LocalStore = BookingStore
    
    let bookingAPI: BookingAPIProtocol
    let localStore: BookingStore
    var isInitialized: Bool = false

    init(bookingAPI: BookingAPIProtocol,
         bookingStore: BookingStore) {
        self.bookingAPI = bookingAPI
        self.localStore = bookingStore
    }
    
    private func refreshBookings(_ bookings: [Booking]) {
        for booking in bookings {
            upsert(entity: booking, key: booking.bookingId)
        }
    }
    
    func fetchBookingForTouristAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?) {
        bookingAPI.getBookingsForTourist(id: id) { [weak self] bookings in
            self?.refreshBookings(bookings)
            self?.saveToLocalStore(models: bookings)
            didRefresh?(bookings)
        }
    }
    
    func fetchBookingForGuideAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?) {
        bookingAPI.getBookingsForGuide(id: id) { [weak self] bookings in
            self?.refreshBookings(bookings)
            self?.saveToLocalStore(models: bookings)
            didRefresh?(bookings)
        }
    }

    func initialFetch(type user: BookingUser,
                      userId: UUID,
                      didFetch: @escaping (([Booking]) -> Void)) {
        if isInitialized {
            didFetch(getAll())
            return
        }

        let fetchFunction = user == .tourist
                ? fetchBookingForTouristAndRefresh
                : fetchBookingForGuideAndRefresh
        
        fetchFunction(userId) { bookings in
            self.isInitialized = true

            if bookings.isEmpty {
                let localBookings = self.retrieveFromLocalStore()
                self.refreshBookings(localBookings)
                didFetch(localBookings)
                return
            }
            
            didFetch(bookings)
        }
    }
}

enum BookingUser {
    case tourist
    case guide
}
