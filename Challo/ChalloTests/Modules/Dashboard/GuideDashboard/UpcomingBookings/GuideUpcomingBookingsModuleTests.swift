//
//  GuideUpcomingBookingsModuleTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 17/4/21.
//

import XCTest
@testable import Challo

class GuideUpcomingBookingsModuleTests: XCTestCase {

    func testAssemble() {
        let userState = MockUserState.createMockLoggedInUserState()
        let bookingRepo = MockBookingRepository()
        let module = GuideUpcomingBookingsModule(userState: userState, bookingRepository: bookingRepo) { _, _, _ in }
        let (_, presenter) = module.assemble()
        let interactor = presenter.interactor
        let router = presenter.router
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor?.presenter)
        XCTAssertNotNil(router?.presenter)
        
    }

}
