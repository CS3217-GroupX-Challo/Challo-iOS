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
    static let feeOne: Int = 10
    static let dateStringOne = "2025-04-02T00:00:00.000Z"
    static let dateOne = Date.construct(with: dateStringOne) ?? Date(timeIntervalSince1970: 100)
    static let guideIdOne = MockGuideAPIResponses.userId
    static let bookingGuideOne = MockGuideAPIResponses.guideOne
    static let trailIdOne = MockTrailAPIResponse.trailIdOne
    static let bookingTrailOne = MockTrailAPIResponse.trailOne
    static let touristIdOne = MockTouristAPIResponse.userId
    static let bookingTouristOne = MockTouristAPIResponse.tourist
    static let createdAtStringOne = "2021-03-30T10:13:01.220Z"
    static let createAtOne = Date.construct(with: createdAtStringOne) ?? Date(timeIntervalSince1970: 100)

    static let bookingIdTwo = UUID(uuidString: "1b4050ed-3c36-41e2-abd4-90b0e348b747") ?? UUID()
    static let statusTwo = "Completed"
    static let statusEnumTwo = BookingStatus(rawValue: statusTwo)!
    static let feeTwo: Int = 1_000
    static let dateStringTwo = "2026-03-02T00:00:00.000Z"
    static let dateTwo = Date.construct(with: dateStringOne) ?? Date(timeIntervalSince1970: 100)
    static let guideIdTwo = MockGuideAPIResponses.userIdTwo
    static let bookingGuideTwo = MockGuideAPIResponses.guideTwo
    static let trailIdTwo = MockTrailAPIResponse.trailIdTwo
    static let bookingTrailTwo = MockTrailAPIResponse.trailTwo
    static let createdAtStringTwo = "2021-03-01T10:13:01.220Z"
    static let createAtTwo = Date.construct(with: createdAtStringTwo) ?? Date(timeIntervalSince1970: 100)

    static var bookingJSONOne: JSON {
        var json = JSON()
        json[Key.bookingId] = bookingIdOne.uuidString
        json[Key.status] = statusOne
        json[Key.fee] = feeOne
        json[Key.date] = dateStringOne
        json[Key.guideId] = guideIdOne.uuidString
        json[Key.trailId] = trailIdOne.uuidString
        json[Key.touristId] = touristIdOne.uuidString
        json[Key.createdAt] = createdAtStringOne
        return json
    }

    static var bookingJSONList: [JSON] {
        [bookingJSONOne]
    }

    static var bookingOne: Booking? {
        guard let trail = bookingTrailOne else {
            return nil
        }

        return Booking(bookingId: bookingIdOne,
                       fee: Double(feeOne),
                       date: dateOne,
                       createdAt: createAtOne,
                       status: statusEnumOne,
                       guide: bookingGuideOne,
                       trail: trail,
                       tourist: bookingTouristOne,
                       review: nil)
    }

    static var bookingJSONTwo: JSON {
        var json = JSON()
        json[Key.bookingId] = bookingIdTwo.uuidString
        json[Key.status] = statusTwo
        json[Key.fee] = Double(feeTwo)
        json[Key.date] = dateStringTwo
        json[Key.guideId] = guideIdTwo.uuidString
        json[Key.trailId] = trailIdTwo.uuidString
        json[Key.touristId] = touristIdOne.uuidString
        json[Key.createdAt] = createdAtStringTwo
        return json
    }

    static var bookingTwo: Booking? {
        guard let trail = bookingTrailTwo else {
            return nil
        }

        return Booking(bookingId: bookingIdTwo,
                       fee: Double(feeTwo),
                       date: dateTwo,
                       createdAt: createAtTwo,
                       status: statusEnumTwo,
                       guide: bookingGuideTwo,
                       trail: trail,
                       tourist: bookingTouristOne,
                       review: nil)
    }

    static var validResponseOne: JSON {
        var json = JSON()
        json["data"] = [bookingJSONOne]
        return json
    }

    static var validResponseTwo: JSON {
        var json = JSON()
        json["data"] = [bookingJSONTwo]
        return json
    }

    static var bookings: [Booking] {
        [bookingOne, bookingTwo]
            .compactMap { $0 }
    }
}
