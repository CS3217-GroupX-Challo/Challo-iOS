//
//  ReviewAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 20/3/21.
//

import XCTest
@testable import Challo

class ReviewAPIParserTests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    typealias Response = MockReviewAPIResponse
    
    let parser = ReviewAPIParser()
    
    func testParseReviews_validResponse_returnsTwoCorrectReviewState() {
        let response = Response.response
        let reviewStates = parser.parseReviews(response: response)
        
        XCTAssertEqual(reviewStates.count, 2, "Parsed incorrectly")
        XCTAssertEqual(reviewStates[0], Response.reviewStateOne, "Parsed incorrectly")
        XCTAssertEqual(reviewStates[1], Response.reviewStateTwo, "Parsed incorrectly")
    }
    
    func testParseReviews_validResponseWithReviewJSONOne_returnsCorrectReviewState() {
        var response = Response.response
        response["data"] = [Response.reviewJSONOne]
        let reviewStates = parser.parseReviews(response: response)
        
        XCTAssertEqual(reviewStates.count, 1, "Parsed incorrectly")
        XCTAssertEqual(reviewStates[0], Response.reviewStateOne, "Parsed incorrectly")
    }
    
    func testParseReviews_validResponseWithReviewJSONTwo_returnsCorrectReviewState() {
        var response = Response.response
        response["data"] = [Response.reviewJSONTwo]
        let reviewStates = parser.parseReviews(response: response)
        
        XCTAssertEqual(reviewStates.count, 1, "Parsed incorrectly")
        XCTAssertEqual(reviewStates[0], Response.reviewStateTwo, "Parsed incorrectly")
    }
    
    func testParseReviews_emptyResponseData_returnsEmptyReviewState() {
        var response = Response.response
        response["data"] = []
        let reviewStates = parser.parseReviews(response: response)
        
        XCTAssertEqual(reviewStates.count, 0, "Parsed incorrectly")
    }
    
    func testParseReviews_invalidResponseData_returnsEmptyReviewState() {
        var response = Response.response
        response["data"] = [Response.reviewStateTwo] // invalid, should be JSON
        let reviewStates = parser.parseReviews(response: response)
        
        XCTAssertEqual(reviewStates.count, 0, "Parsed incorrectly")
    }
    
    func testConvertJSONToReview_withJSONOne_returnCorrectReview() throws {
        let json = Response.reviewJSONOne
        let review = try XCTUnwrap(parser.convertJSONToReview(json: json))
        XCTAssertEqual(review, Response.reviewStateOne, "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withJSONTwo_returnCorrectReview() throws {
        let json = Response.reviewJSONTwo
        let review = try XCTUnwrap(parser.convertJSONToReview(json: json))
        XCTAssertEqual(review, Response.reviewStateTwo, "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withMissingReviewId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.reviewId,
                                               json: Response.reviewJSONOne)
        XCTAssertNil(parser.convertJSONToReview(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withMissingRating_returnsNil() {
        let json = Response.removeUserProperty(key: Key.rating,
                                               json: Response.reviewJSONOne)
        XCTAssertNil(parser.convertJSONToReview(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withMissingGuideId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.guideId,
                                               json: Response.reviewJSONOne)
        XCTAssertNil(parser.convertJSONToReview(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withMissingTrailId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.trailId,
                                               json: Response.reviewJSONOne)
        XCTAssertNil(parser.convertJSONToReview(json: json), "Converted incorrectly")
    }
    
    func testConvertJSONToReview_withMissingTouristId_returnsNil() {
        let json = Response.removeUserProperty(key: Key.touristId,
                                               json: Response.reviewJSONOne)
        XCTAssertNil(parser.convertJSONToReview(json: json), "Converted incorrectly")
    }
}
