//
//  MockBookingAPIResponse.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
@testable import Challo

struct MockBookingAPIResponses {
    typealias JSON = NetworkManager.JSON

    static let bookingIdOne = UUID(uuidString: "3d5efac2-1421-4171-997b-be5607312b5a") ?? UUID()
    static let statusOne = "Pending"
    static let statusEnumOne = BookingStatus(rawValue: statusOne)!
    static let feeOne: Double = 10
    static let dateStringOne = "2021-04-02T00:00:00.000Z"
    static let dateOne = Date.construct(with: dateStringOne) ?? Date(timeIntervalSince1970: 100)
    static let guideIdOne = MockGuideAPIResponses.userId
    static let bookingGuideOne = MockGuideAPIResponses.guideOne
    static let trailIdOne = MockTrailAPIResponse.trailIdOne
    static let bookingTrailOne = MockTrailAPIResponse.trailOne
    static let touristIdOne = MockTouristAPIResponse.userId
    static let bookingTouristOne = MockTouristAPIResponse.tourist
    static let createdAtStringOne = "2021-03-30T10:13:01.220Z"
    static let createAtOne = Date.construct(with: createdAtStringOne) ?? Date(timeIntervalSince1970: 100)

    static var bookingJSONOne: JSON {
        var json = JSON()
        json[Key.bookingId] = bookingIdOne.uuidString
        json[Key.status] = statusOne
        json[Key.fee] = String(feeOne)
        json[Key.date] = dateStringOne
        json[Key.guideId] = guideIdOne.uuidString
        json[Key.trailId] = trailIdOne.uuidString
        json[Key.touristId] = touristIdOne.uuidString
        json[Key.createdAt] = createdAtStringOne
        return json
    }

    static var bookingOne: Booking? {
        guard let trail = bookingTrailOne else {
            return nil
        }

        return Booking(bookingId: bookingIdOne,
                       fee: feeOne,
                       date: dateOne,
                       createdAt: createAtOne,
                       status: statusEnumOne,
                       guide: bookingGuideOne,
                       trail: trail,
                       tourist: bookingTouristOne,
                       review: nil)
    }

    static var validResponse: JSON {
        var json = JSON()
        json["data"] = [bookingJSONOne]
        return json
    }
}
