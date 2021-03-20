//
//  CertificateManagerTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

import XCTest
@testable import Challo

class CertificateManagerTests: XCTestCase {

    typealias JSON = AlamofireManager.JSON
    typealias Responses = MockUserAPIResponses

    let manager = Manager()

    func testParseResponse_validResponse_successfullyParsed() throws {
        let response = Responses.validResponse
        let certificate = try XCTUnwrap(manager.parseUser(apiResponse: response))
        XCTAssertEqual(Responses.name, certificate.name)
        XCTAssertEqual(Responses.email, certificate.email)
        XCTAssertEqual(Responses.tokenString, certificate.token)
        XCTAssertEqual(Responses.userId, certificate.userId)
    }

    func testParseResponse_missingName_failToParse() {
        let response = removeUserProperty(key: "name", json: Responses.validResponse)
        XCTAssertNil(manager.parseUser(apiResponse: response))
    }

    func testParseResponse_missingEmail_failToParse() {
        let response = removeUserProperty(key: "email", json: Responses.validResponse)
        XCTAssertNil(manager.parseUser(apiResponse: response))
    }

    func testParseResponse_missingUserId_failToParse() {
        let response = removeUserProperty(key: "userId", json: Responses.validResponse)
        XCTAssertNil(manager.parseUser(apiResponse: response))
    }

    func testParseResponse_missingToken_failToParse() {
        let response = removeUserProperty(key: "token", json: Responses.validResponse)
        XCTAssertNil(manager.parseUser(apiResponse: response))
    }
}

extension CertificateManagerTests {

    func removeUserProperty(key: String, json: JSON) -> JSON {
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

struct Manager: CertificateManager {
    
}
