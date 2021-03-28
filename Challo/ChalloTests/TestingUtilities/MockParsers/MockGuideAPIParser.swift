//
//  MockGuideAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockGuideAPIParser: GuideAPIParser {
    override func parseGuides(response: GuideAPIParser.JSON) -> [Guide] {
        [MockGuideAPIResponses.guideOne]
    }
    
    override func convertJSONToGuide(json: GuideAPIParser.JSON) -> Guide? {
        MockGuideAPIResponses.guideOne
    }
}
