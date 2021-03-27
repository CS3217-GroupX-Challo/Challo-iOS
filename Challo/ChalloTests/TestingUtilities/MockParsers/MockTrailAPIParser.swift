//
//  MockTrailAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockTrailAPIParser: TrailAPIParser {
    override func parseTrail(response: TrailAPIParser.JSON) -> [Trail] {
        return []
    }
}
