//
//  MockGuideAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 28/3/21.
//

@testable import Challo
import XCTest

class GuideAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testGetGuides_withTwoGuidesFromMocks_getsTwoGuides() {
        let guideAPI = GuideAPI(guideParser: MockGuideAPIParser(),
                                trailParser: MockTrailAPIParser(),
                                networkManager: MockNetworkManager(json: JSON()))
        guideAPI.getGuides { guides in
            XCTAssertEqual(guides.count, 1, "Number of guides is wrong")
            var guide = MockGuideAPIResponses.guideOne
            let trailAPIParser = MockTrailAPIParser()
            guide.trails = trailAPIParser.parseTrail(response: JSON())
            XCTAssertEqual(guides[0], guide, "First guide is wrong")
        }
    }
}
