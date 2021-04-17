//
//  HomestayAPITests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import XCTest
@testable import Challo

class HomestayAPITests: XCTestCase {

    func testGetHomestays_correctHomestaysRetrieved() {
        let mockNetwork = MockNetworkManager(json: MockHomestayAPIResponses.validResponse)
        let api = HomestayAPI(homestayParser: HomestayAPIParser(),
                              hostAPI: MockHostAPI(),
                              networkManager: mockNetwork)
        api.getHomestays { homestays in
            XCTAssertTrue(TestUtils.compareTwoArrays(first: homestays,
                                                     second: MockHomestayAPIResponses.homestays))
        }
    }
}
