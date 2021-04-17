//
//  GuideEarningsPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 3/4/21.
//

import XCTest
@testable import Challo

class GuideEarningsPresenterTests: XCTestCase {

    func testConstructor() {
        let userState = MockUserState.createMockLoggedInUserState()
        let presenter = GuideEarningsPresenter(userState: userState)
        XCTAssertTrue(presenter.loading)
        XCTAssertEqual(userState.name, presenter.name)
    }

}
