//
//  CertificateManagerTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

import XCTest
@testable import Challo

class UserAPIParserTests: XCTestCase {

    typealias JSON = NetworkManager.JSON
    typealias Responses = MockUserAPIResponses

    let parser = UserAPIParser()

    func testParseResponse_validResponse_successfullyParsed() throws {
        let response = Responses.validResponse
        let certificate = try XCTUnwrap(parser.parseUser(apiResponse: response))
        XCTAssertEqual(Responses.name, certificate.name,  "Parsed incorrectly")
        XCTAssertEqual(Responses.email, certificate.email,  "Parsed incorrectly")
        XCTAssertEqual(Responses.tokenString, certificate.token,  "Parsed incorrectly")
        XCTAssertEqual(Responses.userId, certificate.userId,  "Parsed incorrectly")
    }

    func testParseResponse_missingName_failToParse() {
        let response = removeDataProperty(key: "name", json: Responses.validResponse)
        XCTAssertNil(parser.parseUser(apiResponse: response), "Parsed incorrectly")
    }

    func testParseResponse_missingEmail_failToParse() {
        let response = removeDataProperty(key: "email", json: Responses.validResponse)
        XCTAssertNil(parser.parseUser(apiResponse: response), "Parsed incorrectly")
    }

    func testParseResponse_missingUserId_failToParse() {
        let response = removeDataProperty(key: "userId", json: Responses.validResponse)
        XCTAssertNil(parser.parseUser(apiResponse: response),  "Parsed incorrectly")
    }

    func testParseResponse_missingToken_failToParse() {
        let response = removeDataProperty(key: "token", json: Responses.validResponse)
        XCTAssertNil(parser.parseUser(apiResponse: response),  "Parsed incorrectly")
    }
}

extension UserAPIParserTests {

    func removeDataProperty(key: String, json: JSON) -> JSON {
        guard var data = json["data"] as? JSON else {
            XCTFail("JSON not in correct format")
            return JSON()
        }
        _ = data.removeValue(forKey: key)
        var newJson = json
        newJson["data"] = data
        return newJson
    }
        
}
