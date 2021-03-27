//
//  MockReviewsAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import Foundation

class MockReviewsAPI: ReviewAPI {
    init() {
        super.init(reviewParser: ReviewAPIParser(), trailAPI: MockTrailAPI(),
                   touristAPI: TouristAPI(touristParser: TouristAPIParser(),
                                          networkManager: APINetwork.getNetworkManager()),
                   guideAPI: MockGuideAPI(),
                   networkManager: APINetwork.getNetworkManager())
    }
    
    override func getReviewsForGuide(guideId: UUID, callback: @escaping ([Review]) -> Void) {
        let mockReviews = [Review]()
        callback(mockReviews)
    }

    override func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        let mockReviews = [Review]()
        callback(mockReviews)
    }
}
