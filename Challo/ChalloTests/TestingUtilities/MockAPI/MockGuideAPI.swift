//
//  MockGuideAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo

class MockGuideAPI: GuideAPI {
    
    init() {
        super.init(guideParser: GuideAPIParser(),
                   trailParser: TrailAPIParser(),
                   networkManager: APINetwork.getNetworkManager())
    }
    
    override func getGuides(callback: @escaping ([Guide]) -> Void, url: String = "/guide") {
        let mockGuides = [MockGuideAPIResponses.guideOne, MockGuideAPIResponses.guideTwo]
        callback(mockGuides)
    }
}
