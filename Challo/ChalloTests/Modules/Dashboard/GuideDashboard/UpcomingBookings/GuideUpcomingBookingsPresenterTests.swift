//
//  GuideUpcomingBookingsPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 17/4/21.
//

import XCTest
@testable import Challo

class GuideUpcomingBookingsPresenterTests: XCTestCase {

    var presenter: GuideUpcomingBookingsPresenter {
        let userState = MockUserState.createMockLoggedInUserState()
        let bookingRepo = MockBookingRepository()
        let interactor = GuideUpcomingBookingsInteractor(userState: userState, bookingRepository: bookingRepo)
        let presenter = GuideUpcomingBookingsPresenter(userState: userState) { _, _, _ in }
        presenter.interactor = interactor
        return presenter
    }

    func testRefresh() {
        let testCase = presenter
        testCase.refresh()
        XCTAssertFalse(testCase.loading)
        XCTAssertEqual(1, testCase.upcomingBookings.count)
    }

}
