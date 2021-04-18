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
        let trailRepository = MockTrailRepository()
        let guideAPI = MockGuideAPI()
        let userAPI = MockUserAPI()
        return GuideDashboardModule(userState: userState,
                                    bookingRepository: bookingRepository,
                                    trailRepository: trailRepository,
                                    sendMessageToTourist: { _, _, _ in },
                                    updateUserChat: { _, _ in },
                                    userAPI: userAPI,
                                    guideAPI: guideAPI)
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
