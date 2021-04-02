//
//  MockGuideAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

import Foundation
@testable import Challo

class MockGuideAPI: GuideAPI {

    var mockGuides: [Guide]

    init(mockGuides: [Guide]) {
        self.mockGuides = mockGuides
        super.init(guideParser: MockGuideAPIParser(),
                   trailParser: MockTrailAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }

    init() {
        self.mockGuides = [MockGuideAPIResponses.guideOne, MockGuideAPIResponses.guideTwo]
        super.init(guideParser: MockGuideAPIParser(),
                   trailParser: MockTrailAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    override func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        callback(mockGuides)
    }

    override func getGuide(guideId: UUID, callback: @escaping (Guide) -> Void, url: String = "/guide") {
        let mockGuide = mockGuides[0]
        callback(mockGuide)
    }
}
