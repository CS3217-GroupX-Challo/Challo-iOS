//
//  TrailAPITests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import Foundation

class TrailAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testGetAllTrail_withTwoTrailsFromMocks_getsTwoTrails() {
        let trailAPI = TrailAPI(parser: MockTrailAPIParser(),
                                networkManager: MockNetworkManager(json: JSON()))
        trailAPI.getAllTrails { trails in
            XCTAssertEqual(trails.count, 2, "Number of trails is wrong")
            XCTAssertEqual(trails[0], MockTrailAPIResponse.trailOne, "Trail one is wrong")
            XCTAssertEqual(trails[1], MockTrailAPIResponse.trailTwo, "Trail two is wrong")
        }
    }
    
    func testGetTrail_withTrailOneFromMocks_getsTrailOne() {
        let trailAPI = TrailAPI(parser: MockTrailAPIParser(),
                                networkManager: MockNetworkManager(json: JSON()))
        
        trailAPI.getTrail(trailId: UUID()) { trail in
            XCTAssertEqual(trail, MockTrailAPIResponse.trailOne)
        }
    }
}
