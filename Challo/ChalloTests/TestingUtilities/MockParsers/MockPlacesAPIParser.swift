//
//  MockPlacesAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo

class MockPlacesAPIParser: PlacesAPIParser {
    override func convertPlaceJSONToPlace(json: PlacesAPIParser.JSON) -> Place? {
        MockPlacesAPIResponse.place
    }
    
    override func parsePlaces(response: PlacesAPIParser.JSON) -> [Place] {
        [MockPlacesAPIResponse.place, MockPlacesAPIResponse.place]
    }
}
