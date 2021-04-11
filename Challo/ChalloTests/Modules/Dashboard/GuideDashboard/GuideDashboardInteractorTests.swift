//
//  GuideDashboardInteractorTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 3/4/21.
//

import XCTest
@testable import Challo

class GuideDashboardInteractorTests: XCTestCase {

    /// Tests if bookings are retrieved
    func testPopulateBookings() {
        var success = false
        let userState = MockUserState.createMockLoggedInUserState()
        let repository = MockBookingRepository()
        let interactor = GuideEarningsInteractor(userState: userState, bookingRepository: repository)
        interactor.populateBookings { bookings in
            success = !bookings.isEmpty
        }
        XCTAssertTrue(success)
    }

}
