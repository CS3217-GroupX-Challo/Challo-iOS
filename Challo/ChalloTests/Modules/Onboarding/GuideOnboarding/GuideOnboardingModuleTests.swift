//
//  GuideOnboardingModuleTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 18/4/21.
//

import XCTest
@testable import Challo

class GuideOnboardingModuleTests: XCTestCase {

    var module: GuideOnboardingModule {
        GuideOnboardingModule(userState: MockUserState.createMockLoggedInUserState(),
                              trailRepository: MockTrailRepository(),
                              guideAPI: MockGuideAPI())
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
