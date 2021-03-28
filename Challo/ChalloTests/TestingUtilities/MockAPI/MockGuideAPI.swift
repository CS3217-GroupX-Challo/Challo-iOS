//
//  MockGuideAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo

class MockGuideAPI: GuideAPI {
    
    init() {
        super.init(guideParser: MockGuideAPIParser(),
                   trailParser: MockTrailAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    override func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        let mockGuides = [MockGuideAPIResponses.guideOne, MockGuideAPIResponses.guideTwo]
        callback(mockGuides)
    }
}
