//
//  BookingInfoRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

protocol BookingInfoRepositoryProtocol {
    func getAllBookings() -> [BookingPersistenceObject]
    func saveBookings(bookingObjects: [BookingPersistenceObject])
}
