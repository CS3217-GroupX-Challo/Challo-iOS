//
//  GuideDashboardModuleTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 3/4/21.
//

import XCTest
@testable import Challo

class GuideDashboardModuleTests: XCTestCase {

    func testAssemble() {
        let userState = MockUserState()
        let bookingRepository = MockBookingRepository()
        let module = GuideEarningsModule(userState: userState, bookingRepository: bookingRepository)
        let (view, presenter) = module.assemble()
        XCTAssertNotNil(view, "View was not properly initialised")
        XCTAssertNotNil(presenter, "Presenter was not properly initialised")
        guard let interactor = presenter.interactor, let router = presenter.router else {
            XCTFail("Parts were not properly assembled")
            return
        }
        XCTAssertNotNil(interactor.presenter)
        XCTAssertNotNil(router.presenter)
    }

}
