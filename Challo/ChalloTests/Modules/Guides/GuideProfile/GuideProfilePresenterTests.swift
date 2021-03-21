//
//  GuideProfilePresenterTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest

class GuideProfilePresenterTests: XCTestCase {
    func testConstruct() {
        let presenter = GuideProfilePresenter(guide: MockGuideAPIResponses.guideOne)
        XCTAssertEqual(presenter.guide, MockGuideAPIResponses.guideOne, "Not initialized properly")
        XCTAssertEqual(presenter.reviews.count, 0, "not initialized properly")
    }
}
