//
//  GuideUpcomingBookingsInteractorTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 17/4/21.
//

import XCTest
@testable import Challo

class GuideUpcomingBookingsInteractorTests: XCTestCase {

    func testPopulateBookings() {
        var success = false
        let repo = MockBookingRepository()
        let userState = MockUserState.createMockLoggedInUserState()
        let interactor = GuideUpcomingBookingsInteractor(userState: userState, bookingRepository: repo)
        interactor.populateBookings { bookings in
            success = !bookings.isEmpty
        }
        XCTAssertTrue(success)
    }

}
