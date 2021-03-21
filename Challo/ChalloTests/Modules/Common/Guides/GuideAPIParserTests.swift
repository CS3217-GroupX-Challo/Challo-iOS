//
//  GuideAPIParserTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class GuideAPIParserTests: XCTestCase {

    typealias Responses = MockGuideAPIResponses
    private let parser = GuideAPIParser()

    func testConvertJSONToGuide_validJSON_successfullyParsed() throws {
        let json = Responses.guideJSONOne
        let guide = try XCTUnwrap(parser.convertJSONToGuide(json: json))
        XCTAssertEqual(Responses.guideOne, guide, "Converted incorrectly")
    }

    func testConvertJSONToGuide_missingUserID_returnsNil() {
        let json = Responses.removeUserProperty(key: Key.userId, json: Responses.guideJSONOne)
        XCTAssertNil(parser.convertJSONToGuide(json: json), "Converted incorrectly")
    }

    func testConvertJSONToGuide_missingEmail_returnsNil() {
        let json = Responses.removeUserProperty(key: Key.email, json: Responses.guideJSONOne)
        XCTAssertNil(parser.convertJSONToGuide(json: json), "Converted incorrectly")
    }

    func testParseGuides_validResponse_returnsCorrectGuides() {
        let response = Responses.validResponse
        let guides = parser.parseGuides(response: response)

        XCTAssertEqual(2, guides.count, "Parsed incorrectly")
        XCTAssertEqual(Responses.guideOne, guides[0], "Parsed incorrectly")
        XCTAssertEqual(Responses.guideTwo, guides[1], "Parsed incorrectly")
    }

    func testParseGuides_withGuideOne_returnsCorrectGuides() {
        var response = Responses.validResponse
        response["data"] = [Responses.guideJSONOne]
        let guides = parser.parseGuides(response: response)
    
        XCTAssertEqual(1, guides.count, "Parsed incorrectly")
        XCTAssertEqual(Responses.guideOne, guides[0], "Parsed incorrectly")
    }

    func testParseGuides_emptyResponseData_returnsEmptyCollection() {
        var response = Responses.validResponse
        response["data"] = []
        let guides = parser.parseGuides(response: response)

        XCTAssertTrue(guides.isEmpty, "Parsed incorrectly")
    }

    func testParseGuides_invalidData_returnsEmptyCollection() {
        var response = Responses.validResponse
        response["data"] = [Responses.guideOne] // invalid as JSON is expected
        let guides = parser.parseGuides(response: response)

        XCTAssertTrue(guides.isEmpty, "Parsed incorrectly")
    }
}
