//
//  GuideBookingHistorySubPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 4/4/21.
//

import XCTest
@testable import Challo

class GuideBookingHistorySubPresenterTests: XCTestCase {

    func testRefresh_allCompletedTrailsLoaded() {
        let userState = MockUserState.createMockLoggedInUserState()
        let repo = MockBookingRepository()
        let interactor = GuideEarningsInteractor(userState: userState,
                                                 bookingRepository: repo)
        let subPresenter = GuideBookingHistorySubPresenter()
        subPresenter.interactor = interactor

        subPresenter.refresh()
        XCTAssertFalse(subPresenter.loading)
        let expectedBookings = MockBookingAPIResponses.bookings
            .filter { $0.status == .Completed }
        XCTAssertEqual(subPresenter.completedBookings, expectedBookings)
        let expectedEarnings = expectedBookings.reduce(0.0, { $0 + $1.fee })
        XCTAssertEqual(subPresenter.totalEarnings, expectedEarnings)
    }

}
