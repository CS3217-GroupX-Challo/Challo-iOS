//
//  BookingAPIParserTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
import XCTest
@testable import Challo

class BookingAPIParserTests: XCTestCase {

    typealias Response = MockBookingAPIResponses
    let parser = BookingAPIParser()

    func testExtractTrailID_correctTrailIDReturned() {
        let json = Response.bookingJSONOne
        let extractedId = parser.extractTrailID(json: json)
        XCTAssertEqual(Response.trailIdOne, extractedId, "Wrong trail id extracted from json")
    }

    func testExtractGuideID_correctGuideIDReturned() {
        let json = Response.bookingJSONOne
        let extractedId = parser.extractGuideID(json: json)
        XCTAssertEqual(Response.guideIdOne, extractedId, "Wrong guide id extracted from json")
    }

    func testExtractTouristID_correctTouristIDReturned() {
        let json = Response.bookingJSONOne
        let extractedId = parser.extractTouristID(json: json)
        XCTAssertEqual(Response.touristIdOne, extractedId, "Wrong tourist id extracted from json")
    }

    func testConvertJsonToBooking_correctBookingReturned() {
        let json = Response.bookingJSONOne
        let guide = Response.bookingGuideOne
        let tourist = Response.bookingTouristOne
        guard let trail = Response.bookingTrailOne else {
            XCTFail("Testing trail is nil")
            return
        }
        let convertedBooking = parser.convertJSONToBooking(json: json,
                                                           guide: guide,
                                                           trail: trail,
                                                           tourist: tourist)
        XCTAssertEqual(Response.bookingOne, convertedBooking)
    }
}
