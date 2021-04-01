//
//  BookingAPITests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import XCTest
@testable import Challo

class BookingAPITests: XCTestCase {

    typealias JSON = NetworkManager.JSON

    private let bookingAPI = BookingAPI(bookingParser: MockBookingAPIParser(),
                                        networkManager: MockNetworkManager(json: JSON()),
                                        guideAPI: MockGuideAPI(),
                                        touristAPI: MockTouristAPI(),
                                        trailAPI: MockTrailAPI(),
                                        reviewAPI: MockReviewsAPI())

    func testGetBookingsForTourist_correctBookingsRetrieved() {
        bookingAPI.getBookingsForTourist(id: UUID()) { bookings in
            XCTAssertEqual(MockBookingAPIResponses.bookings, bookings)
        }
    }

    func testGetBookingsForGuide_correctBookingsRetrieved() {
        bookingAPI.getBookingsForGuide(id: UUID()) { bookings in
            XCTAssertEqual(MockBookingAPIResponses.bookings, bookings)
        }
    }
}
