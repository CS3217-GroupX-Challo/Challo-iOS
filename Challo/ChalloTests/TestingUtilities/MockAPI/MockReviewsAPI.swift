//
//  MockReviewsAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import Foundation

class MockReviewsAPI: ReviewAPI {
    typealias JSON = NetworkManager.JSON
    
    init() {
        super.init(reviewParser: MockReviewAPIParser(), trailAPI: MockTrailAPI(),
                   touristAPI: MockTouristAPI(),
                   guideAPI: MockGuideAPI(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    override func getReviewsForGuide(guideId: UUID, callback: @escaping ([Review]) -> Void) {
        let mockReviews = [Review]()
        callback(mockReviews)
    }

    override func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        let mockReviews = [Review]()
        callback(mockReviews)
    }

    override func getReviewForBooking(bookingId: UUID, guide: Guide, trail: Trail, tourist: Tourist, callback: @escaping (Review?) -> Void) {
        callback(nil)
    }
}
