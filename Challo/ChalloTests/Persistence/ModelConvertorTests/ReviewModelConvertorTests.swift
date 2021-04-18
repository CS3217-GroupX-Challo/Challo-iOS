//
//  ReviewModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class ReviewModelConvertorTests: XCTestCase {
    static let area = Area(areaId: UUID(),
                           village: "Test",
                           division: "Test",
                           state: "Test srare",
                           country: "ypee")

    static let trail = Trail(trailId: UUID(), title: "trail one", description: "test",
                             rating: 1, difficulty: .Difficult, positions: [],
                             distance: 12.3, duration: 122, elevation: 12,
                             images: ["hgi"], area: ReviewModelConvertorTests.area,
                             guideIds: [],
                             numOfReviews: 2, lowestFee: 122, tags: ["best"],
                             landmarks: ["sn"])
    
    let review = Review(reviewId: UUID(),
                        rating: 5,
                        comment: "hello",
                        guide: MockGuideAPIResponses.guideOne,
                        trail: trail,
                        createdAt: Date(),
                        tourist: MockTouristAPIResponse.tourist)
    
    let convertor = ReviewModelConvertor(guideModelConvertor:
                                            GuideModelConvertor(areaModelConvertor: AreaModelConvertor(),
                                                                trailModelConvertor:
                                                                    TrailModelConvertor(convertor:
                                                                                            AreaModelConvertor())),
                                         touristModelConvertor: TouristModelConvertor(),
                                         trailModelConvertor: TrailModelConvertor(convertor: AreaModelConvertor()))
    
    func testConvertModelToPersistenceObject_withReview_returnsPersistenceObjectWithCorrectProperties() {
        let reviewObject = convertor.convertModelToPersistenceObject(model: review)
        XCTAssertEqual(review.reviewId, reviewObject.reviewId, "Should be equal")
        XCTAssertEqual(review.rating, reviewObject.rating, "Should be equal")
        XCTAssertEqual(review.comment, reviewObject.comment, "Should be equal")
        XCTAssertEqual(review.createdAt, reviewObject.createdAt, "Should be equal")
    }
    
    func testConvertPersistenceObjectToModel_withReviewToAndFro_sameReviewReturned() {
        let reviewObject = convertor.convertModelToPersistenceObject(model: review)
        let reviewReturned = convertor.convertPersistenceObjectToModel(object: reviewObject)
        XCTAssertEqual(review, reviewReturned, "Should be equal")
    }
}
