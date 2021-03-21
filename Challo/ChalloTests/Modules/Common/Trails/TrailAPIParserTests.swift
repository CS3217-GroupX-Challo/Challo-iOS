//
//  TrailAPIParserTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

import XCTest
@testable import Challo

class TrailAPIParserTests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    typealias Response = MockTrailAPIResponse
    
    let parser = TrailAPIParser()
    
    func testParseTrail_responseWithTwoTrails_returnsTwoCorrectTrail() {
        let response = Response.response
        let trails = parser.parseTrail(response: response)
        XCTAssertEqual(trails.count, 2, "Parsed incorrectly")
        XCTAssertEqual(trails[0], Response.trailOne)
        XCTAssertEqual(trails[1], Response.trailTwo)
    }
    
    func testParseTrail_responseWithTrailJSONOne_returnsCorrectTrail() {
        var response = Response.response
        response["data"] = [Response.trailJSONOne]
        let trails = parser.parseTrail(response: response)
        XCTAssertEqual(trails.count, 1, "Parsed incorrectly")
        XCTAssertEqual(trails[0], Response.trailOne)
    }
    
    func testParseTrail_responseWithTrailJSONTwo_returnsCorrectTrail() {
        var response = Response.response
        response["data"] = [Response.trailJSONTwo]
        let trails = parser.parseTrail(response: response)
        XCTAssertEqual(trails.count, 1, "Parsed incorrectly")
        XCTAssertEqual(trails[0], Response.trailTwo)
    }
    
    func testParseTrail_emptyResponse_returnsNoTrail() {
        var response = Response.response
        response["data"] = []
        let trails = parser.parseTrail(response: response)
        XCTAssertEqual(trails.count, 0, "Parsed incorrectly")
    }
    
    func testParseTrail_invalidResponse_returnsNoTrail() {
        var response = Response.response
        response["data"] = [Response.trailTwo] // should be JSON not some struct
        let trails = parser.parseTrail(response: response)
        XCTAssertEqual(trails.count, 0, "Parsed incorrectly")
    }
    
    func testConvertJSONToTrail_withTrailJSONOne_returnsCorrectTrail() throws {
        let json = Response.trailJSONOne
        let trail = try XCTUnwrap(parser.convertJSONToTrail(json: json))
        XCTAssertEqual(trail, Response.trailOne, "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_withTrailJSONTwo_returnsCorrectTrail() throws {
        let json = Response.trailJSONTwo
        let trail = try XCTUnwrap(parser.convertJSONToTrail(json: json))
        XCTAssertEqual(trail, Response.trailTwo, "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingTrailId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.trailId,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingTitle_returnsNil() {
        let json = Response.removeUserProperty(key: Key.title,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingDescription_returnsNil() {
        let json = Response.removeUserProperty(key: Key.description,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingPositions_returnsNil() {
        let json = Response.removeUserProperty(key: Key.positions,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingDistance_returnsNil() {
        let json = Response.removeUserProperty(key: Key.distance,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToTrail_missingArea_returnsNil() {
        let json = Response.removeUserProperty(key: Key.area,
                                               json: Response.trailJSONOne)
        XCTAssertNil(parser.convertJSONToTrail(json: json), "Converted incorrectly")
    }
}
