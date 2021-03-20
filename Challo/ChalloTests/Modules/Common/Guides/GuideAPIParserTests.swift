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
        let json = Responses.validGuideJSON
        let guide = try XCTUnwrap(parser.convertJSONToGuide(json: json))
        compareParsedGuide(guide: guide)
    }

    func testConvertJSONToGuide_missingUserID_returnsNil() {
        let json = Responses.removeUserProperty(key: Key.userId, json: Responses.validGuideJSON)
        XCTAssertNil(parser.convertJSONToGuide(json: json))
    }

    func testConvertJSONToGuide_missingEmail_returnsNil() {
        let json = Responses.removeUserProperty(key: Key.email, json: Responses.validGuideJSON)
        XCTAssertNil(parser.convertJSONToGuide(json: json))
    }
}

extension GuideAPIParserTests {

    private func compareParsedGuide(guide: Guide) {
        XCTAssertEqual(Responses.name, guide.name)
        XCTAssertEqual(Responses.email, guide.email)
        XCTAssertEqual(Responses.biography, guide.biography)
        XCTAssertEqual(Responses.accrediations, guide.accreditations)
        XCTAssertEqual(Responses.dateJoinedParsed, guide.dateJoined)
        XCTAssertEqual(Responses.phone, guide.phone)
        XCTAssertEqual(Responses.userUUID, guide.userId)
        XCTAssertEqual(Responses.sexEnum, guide.sex)
    }
}
