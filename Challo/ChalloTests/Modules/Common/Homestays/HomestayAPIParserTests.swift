//
//  HomestayAPIParserTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import XCTest
@testable import Challo

class HomestayAPIParserTests: XCTestCase {

    typealias Responses = MockHomestayAPIResponses
    let parser = HomestayAPIParser()
    
    func testConvertJSONToHomestay_missingId_returnsNil() {
        var json = Responses.homestayJSONOne
        json.removeValue(forKey: Key.homestayId)
        XCTAssertNil(parser.convertJSONToHomestay(json: json, host: Responses.hostOne),
                     "JSON with no homestayId property should not be converted")
    }

    func testConvertJSONToHomestay_missingTitle_returnsNil() {
        var json = Responses.homestayJSONOne
        json.removeValue(forKey: Key.title)
        XCTAssertNil(parser.convertJSONToHomestay(json: json, host: Responses.hostOne),
                     "JSON with no title property should not be converted")
    }

    func testConvertJSONToHomestay_missingCapacity_returnsNil() {
        var json = Responses.homestayJSONOne
        json.removeValue(forKey: Key.capacity)
        XCTAssertNil(parser.convertJSONToHomestay(json: json, host: Responses.hostOne),
                     "JSON with no capacity property should not be converted")
    }

    func testConvertJSONToHomestay_missingLocation_returnsNil() {
        var json = Responses.homestayJSONOne
        json.removeValue(forKey: Key.location)
        XCTAssertNil(parser.convertJSONToHomestay(json: json, host: Responses.hostOne),
                     "JSON with no capacity property should not be converted")
    }

    func testConvertJSONToHomestay_allFieldsValid_returnsCorrectHomestay() {
        let json = Responses.homestayJSONOne
        let expected = Responses.homestayOne
        let actual = parser.convertJSONToHomestay(json: json, host: Responses.hostOne)
        XCTAssertEqual(expected, actual)
    }
}
