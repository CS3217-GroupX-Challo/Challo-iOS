//
//  MockTrailAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockTrailAPIParser: TrailAPIParser {
    override func parseTrail(response: TrailAPIParser.JSON) -> [Trail] {
        guard let trailOne = MockTrailAPIResponse.trailOne,
              let trailTwo = MockTrailAPIResponse.trailTwo else {
            return []
        }
        
        return [trailOne, trailTwo]
    }
    
    override func convertJSONToTrail(json: TrailAPIParser.JSON) -> Trail? {
        MockTrailAPIResponse.trailOne
    }
}
