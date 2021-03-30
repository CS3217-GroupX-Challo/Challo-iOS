//
//  BookingAPIProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

protocol BookingAPIProtocol {

    func getBookingsForTourist(id: UUID, callback: @escaping ([Booking]) -> Void, url: String)
    func getBookingsForGuide(id: UUID, callback: @escaping ([Booking]) -> Void, url: String)
}
