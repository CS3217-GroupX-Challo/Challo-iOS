//
//  GuideDashboardPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 3/4/21.
//

import XCTest
@testable import Challo

class GuideDashboardPresenterTests: XCTestCase {

    func testConstructor() {
        let userState = MockUserState.createMockLoggedInUserState()
        let presenter = GuideDashboardPresenter(userState: userState)
        XCTAssertTrue(presenter.loading)
        XCTAssertEqual(userState.name, presenter.name)
    }

    func testRefresh_loadingComplete_earningsUpdated() {
        let userState = MockUserState.createMockLoggedInUserState()
        let repository = MockBookingRepository()
        let interactor = GuideDashboardInteractor(userState: userState, bookingRepository: repository)
        let presenter = GuideDashboardPresenter(userState: userState)
        presenter.interactor = interactor
        presenter.refresh()
        XCTAssertFalse(presenter.loading)

        let expectedEarnings = MockBookingAPIResponses.bookings
            .filter { $0.status == .Completed }
            .reduce(0.0, { $0 + $1.fee })
        XCTAssertEqual(expectedEarnings, presenter.totalEarnings)
    }

    func testUpdateTotalEarnings() {
        let bookings = MockBookingAPIResponses.bookings
        var totalEarnings = 0.0
        for booking in bookings where booking.status == .Completed {
            totalEarnings += booking.fee
        }
        let userState = MockUserState.createMockLoggedInUserState()
        let presenter = GuideDashboardPresenter(userState: userState)
        presenter.updateTotalEarnings(bookings: bookings)
        XCTAssertEqual(totalEarnings, presenter.totalEarnings)
    }
}
