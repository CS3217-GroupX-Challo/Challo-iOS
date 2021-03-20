//
//  AreaAPIParserTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class AreaAPIParserTests: XCTestCase {

    typealias Responses = MockAreaAPIResponse

    private let parser = AreaAPIParser()

    func testConvertJSONToArea_withJSONOne_returnCorrectArea() throws {
        let json = Responses.areaJSONOne
        let area = try XCTUnwrap(parser.convertJSONToArea(json: json), "Failed to convert json")
        XCTAssertEqual(Responses.areaStateOne, area)
    }

    func testConvertJSONToArea_withJSONTwo_returnCorrectArea() throws {
        let json = Responses.areaJSONTwo
        let area = try XCTUnwrap(parser.convertJSONToArea(json: json), "Failed to convert json")
        XCTAssertEqual(Responses.areaStateTwo, area)
    }

    func testConvertJSONToArea_areaIDRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.areaId, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json))
    }

    func testConvertJSONToArea_stateRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.state, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json))
    }

    func testConvertJSONToArea_countryRemoved_returnsNil() throws {
        let json = Responses.removeUserProperty(key: Key.country, json: Responses.areaJSONOne)
        XCTAssertNil(parser.convertJSONToArea(json: json))
    }

    func testParseAreas_validResponse_returnsCorrectAreas() {
        let response = Responses.validAreaResponse
        let areas = parser.parseAreas(response: response)

        XCTAssertEqual(2, areas.count)
        XCTAssertEqual(Responses.areaStateOne, areas[0])
        XCTAssertEqual(Responses.areaStateTwo, areas[1])
    }

    func testParseAreas_validResponseWithJSONOne_returnsCorrectAreas() {
        var response = Responses.validAreaResponse
        response["data"] = [Responses.areaJSONOne]
        let areas = parser.parseAreas(response: response)

        XCTAssertEqual(1, areas.count)
        XCTAssertEqual(Responses.areaStateOne, areas[0])
    }

    func testParseAreas_emptyResponseData_returnsEmptyCollection() {
        var response = Responses.validAreaResponse
        response["data"] = []
        let areas = parser.parseAreas(response: response)

        XCTAssertTrue(areas.isEmpty)
    }

    func testParseAreas_invalidResponseData_returnsEmptyCollection() {
        var response = Responses.validAreaResponse
        response["data"] = Responses.areaStateOne
        let areas = parser.parseAreas(response: response)

        XCTAssertTrue(areas.isEmpty)
    }
    
}
