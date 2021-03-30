//
//  AreaAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 28/3/21.
//

@testable import Challo
import XCTest

class AreaAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testGetAreas_withTwoAreasFromMocks_getsTwoAreas() {
        let areaAPI = AreaAPI(areaParser: MockAreaAPIParser(),
                              networkManager: MockNetworkManager(json: JSON()))
        areaAPI.getAreas { areas in
            XCTAssertEqual(areas.count, 2, "Number of areas is wrong")
            XCTAssertEqual(areas[0], MockAreaAPIResponse.areaStateOne, "Area one is wrong")
            XCTAssertEqual(areas[1], MockAreaAPIResponse.areaStateTwo, "Area two is wrong")
        }
    }
}
