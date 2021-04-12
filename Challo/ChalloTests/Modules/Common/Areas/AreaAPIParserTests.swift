//
//  AreaAPIParserTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

import XCTest
@testable import Challo

class AreaAPIParserTests: XCTestCase {

    typealias Responses = MockAreaAPIResponse

    private let parser = AreaAPIParser()

    func testConvertJSONToArea_withJSONOne_returnCorrectArea() throws {
        let json = Responses.areaJSONOne
        let area = try XCTUnwrap(parser.convertJSONToArea(json: json), "Failed to convert json")
        XCTAssertEqual(Responses.areaStateOne, area, "Converted incorrectly")
    }

    func testConvertJSONToArea_withJSONTwo_returnCorrectArea() throws {
        let json = Responses.areaJSONTwo
        let area = try XCTUnwrap(parser.convertJSONToArea(json: json), "Failed to convert json")
        XCTAssertEqual(Responses.areaStateTwo, area, "Converted incorrectly")
    }

    func testConvertJSONToArea_areaIDRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.areaId, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json), "Converted incorrectly")
    }

    func testConvertJSONToArea_stateRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.state, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json), "Converted incorrectly")
    }

    func testConvertJSONToArea_countryRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.country, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json), "Parsed incorrectly")
    }

    func testParseAreas_validResponse_returnsCorrectAreas() {
        let response = Responses.validAreaResponse
        let areas = parser.parseAreas(response: response)

        XCTAssertEqual(2, areas.count, "Parsed incorrectly")
        XCTAssertEqual(Responses.areaStateOne, areas[0], "Parsed incorrectly")
        XCTAssertEqual(Responses.areaStateTwo, areas[1], "Parsed incorrectly")
    }

    func testParseAreas_validResponseWithJSONOne_returnsCorrectAreas() {
        var response = Responses.validAreaResponse
        response["data"] = [Responses.areaJSONOne]
        let areas = parser.parseAreas(response: response)

        XCTAssertEqual(1, areas.count, "Parsed incorrectly")
        XCTAssertEqual(Responses.areaStateOne, areas[0], "Parsed incorrectly")
    }

    func testParseAreas_emptyResponseData_returnsEmptyCollection() {
        var response = Responses.validAreaResponse
        response["data"] = []
        let areas = parser.parseAreas(response: response)

        XCTAssertTrue(areas.isEmpty, "Parsed incorrectly")
    }

    func testParseAreas_invalidResponseData_returnsEmptyCollection() {
        var response = Responses.validAreaResponse
        response["data"] = Responses.areaStateOne
        let areas = parser.parseAreas(response: response)

        XCTAssertTrue(areas.isEmpty, "Parsed incorrectly")
    }
    
}
