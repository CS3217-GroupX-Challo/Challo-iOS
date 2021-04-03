//
//  PlacesAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest

class PlacesAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON

    func testGetPlaces_withThreePlaces_returnsCorrectPlaces() {
        let api = PlacesAPI(parser: MockPlacesAPIParser(),
                            networkManager: MockNetworkManager(json: JSON()))
        let place = MockPlacesAPIResponse.place
        api.getPlaces(with: "") { places in
            XCTAssertEqual(places.count, 2, "Should have three")
            XCTAssertEqual(places, [place, place], "Should be equal")
        }
    }
}
