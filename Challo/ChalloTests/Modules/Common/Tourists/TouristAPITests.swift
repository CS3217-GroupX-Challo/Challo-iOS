//
//  TouristAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 28/3/21.
//

@testable import Challo
import XCTest
import Foundation

class TouristAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testGetTourist_withMockedResponse_getCorrectTourist() {
        let touristAPI = TouristAPI(touristParser: MockTouristAPIParser(),
                                    networkManager: MockNetworkManager(json: JSON()))
        touristAPI.getTourist(userId: UUID()) { tourist in
            XCTAssertEqual(tourist, MockTouristAPIResponse.tourist, "Tourist returned not correct")
        }
    }
}
