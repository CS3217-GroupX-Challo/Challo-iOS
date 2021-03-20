//
//  TouristAPIParserTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

import XCTest
@testable import Challo

class TouristAPIParserTests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    typealias Response = MockTouristAPIResponse

    let parser = TouristAPIParser()
    
    func testConvertJSONToTourist_validTouristJSON_returnsTourist() throws {
        let touristJSON = MockTouristAPIResponse.validTouristJSON
        let tourist = try XCTUnwrap(parser.convertJSONToTourist(json: touristJSON))
        XCTAssertEqual(Response.userId, tourist.userId, "Parsed incorrectly")
        XCTAssertEqual(Response.email, tourist.email, "Parsed incorrectly")
        XCTAssertEqual(Response.name, tourist.name, "Parsed incorrectly")
        XCTAssertEqual(Response.phone, tourist.phone, "Parsed incorrectly")
        XCTAssertEqual(Response.profileImg, tourist.profileImg, "Parsed incorrectly")
        XCTAssertEqual(Response.dateJoined, tourist.dateJoined, "Parsed incorrectly")
        XCTAssertEqual(Response.sex, tourist.sex, "Parsed incorrectly")
    }
    
    func testConvertJSONToTourist_missingName_returnsNil() {
        let json = Response.removeUserProperty(key: Key.name,
                                               json: Response.validTouristJSON)
        XCTAssertNil(parser.convertJSONToTourist(json: json), "Parsed incorrectly")
    }
    
    func testConvertJSONToTourist_missingEmail_returnsNil() {
        let json = Response.removeUserProperty(key: Key.email,
                                               json: Response.validTouristJSON)
        XCTAssertNil(parser.convertJSONToTourist(json: json), "Parsed incorrectly")
    }
    
    func testConvertJSONToTourist_missingUserId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.userId,
                                               json: Response.validTouristJSON)
        XCTAssertNil(parser.convertJSONToTourist(json: json), "Parsed incorrectly")
    }
}
