//
//  MockAreaAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockAreaAPIParser: AreaAPIParser {
    override func parseAreas(response: AreaAPIParser.JSON) -> [Area] {
        [MockAreaAPIResponse.areaStateOne, MockAreaAPIResponse.areaStateTwo]
    }
    
    override func convertJSONToArea(json: AreaAPIParser.JSON) -> Area? {
        MockAreaAPIResponse.areaStateOne
    }
}
