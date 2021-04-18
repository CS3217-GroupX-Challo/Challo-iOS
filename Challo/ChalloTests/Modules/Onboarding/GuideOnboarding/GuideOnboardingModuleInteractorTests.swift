//
//  GuideOnboardingModuleInteractorTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 18/4/21.
//

import XCTest
@testable import Challo

class GuideOnboardingModuleInteractorTests: XCTestCase {

    var interactor: GuideOnboardingInteractor {
        let userState = MockUserState.createMockLoggedInUserState()
        let onboardingAPI = GuideOnboardingAPI(userState: userState, guideAPI: MockGuideAPI())
        return GuideOnboardingInteractor(userState: userState,
                                         trailRepository: MockTrailRepository(),
                                         userParser: MockUserAPIParser(userState: userState),
                                         certificateManager: MockCertificateManager(state: userState),
                                         onboardingAPI: onboardingAPI)
    }

    func testFetchTrailsAndAreas() {
        let testCase = interactor
        let presenter = GuideOnboardingPresenter(userState: interactor.userState)
        testCase.presenter = presenter
        testCase.fetchTrailsAndAreas()
        XCTAssertTrue(presenter.loaded)
        let expected = [MockTrailAPIResponse.trailOne, MockTrailAPIResponse.trailTwo].compactMap { $0 }
        XCTAssertEqual(expected, presenter.trails)
    }

}
