//
//  ReviewAPITests.swift
//  ChalloTests
//
//  Created by Kester Ng on 28/3/21.
//

@testable import Challo
import XCTest
import Foundation

class ReviewAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testGetReviewsForGuide_emptyReviews_nothingHappens() {
        let reviewAPI = ReviewAPI(reviewParser: MockReviewAPIParser(),
                                  trailAPI: MockTrailAPI(),
                                  touristAPI: MockTouristAPI(),
                                  guideAPI: MockGuideAPI(),
                                  networkManager: MockNetworkManager(json: JSON()))
        reviewAPI.getReviewsForGuide(guideId: UUID()) { _ in
            XCTFail("Not supposed to come here")
        }
    }
    
    func testGetReviewsForTrail_emptyReviews_nothingHappens() {
        let reviewAPI = ReviewAPI(reviewParser: MockReviewAPIParser(),
                                  trailAPI: MockTrailAPI(),
                                  touristAPI: MockTouristAPI(),
                                  guideAPI: MockGuideAPI(),
                                  networkManager: MockNetworkManager(json: JSON()))
        reviewAPI.getReviewsForTrail(trailId: UUID()) { _ in
            XCTFail("Not supposed to come here")
        }
    }
}
