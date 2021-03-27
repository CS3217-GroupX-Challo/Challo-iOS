//
//  MockTouristAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockTouristAPIParser: TouristAPIParser {
    override func convertJSONToTourist(json: TouristAPIParser.JSON) -> Tourist? {
        return nil
    }
}
