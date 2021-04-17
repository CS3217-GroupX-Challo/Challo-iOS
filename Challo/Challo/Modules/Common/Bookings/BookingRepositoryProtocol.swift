//
//  BookingRepositoryProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

protocol BookingRepositoryProtocol: Repository<UUID, Booking> {
    func fetchBookingForTouristAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?)
    func fetchBookingForGuideAndRefresh(id: UUID, didRefresh: (([Booking]) -> Void)?)
    func initialFetch(type user: BookingUser,
                      userId: UUID,
                      didFetch: @escaping (([Booking]) -> Void))
}
