//
//  TouristDashboardPresenterTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import XCTest
@testable import Challo

class TouristDashboardPresenterTests: XCTestCase {

    func testConstruct_nameObservablePropertyInitializedProperly() {
        let userState = MockUserState.createMockLoggedInUserState()
        let presenter = TouristDashboardPresenter(userState: userState)
        XCTAssertEqual(userState.name, presenter.name)
    }
}
