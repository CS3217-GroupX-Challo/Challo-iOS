//
//  GuideDashboardModuleTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 18/4/21.
//

import XCTest
@testable import Challo

class GuideDashboardModuleTests: XCTestCase {

    var module: GuideDashboardModule {
        let userState = MockUserState.createMockLoggedInUserState()
        let bookingRepository = MockBookingRepository()
        let userAPI = MockUserAPI()
        return GuideDashboardModule(userState: userState,
                                    bookingRepository: bookingRepository,
                                    sendMessageToTourist: { _, _, _ in },
                                    updateUserChat: { _, _ in },
                                    userAPI: userAPI)
    }

    func testAssemble() {
        let (_, presenter) = module.assemble()
        let interactor = presenter.interactor
        let router = presenter.router
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor?.presenter)
        XCTAssertNotNil(router?.presenter)
    }

}
