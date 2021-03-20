//
//  ReviewAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

/// It conforms to trail API and UserAPI as data from reviewAPI is dependent on
/// the two APIs aforementioned
class ReviewAPI {

    let reviewParser = ReviewAPIParser()
    let trailAPI = TrailAPI()
    let touristAPI = TouristAPI()
    let guideAPI = GuideAPI()

    func getReviewsForGuide(guideId: UUID,
                            callback: @escaping ([Review]) -> Void,
                            url: String = "/review?guideId=") {
        let api = APINetwork.api
        api.get(url: url + guideId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }

            let reviewStates: [ReviewState] = self.reviewParser.parseReviews(response: response)
            var reviews: [Review] = []
            for reviewState in reviewStates {
                self.trailAPI.getTrail(trailId: reviewState.trailId) { trail in
                    self.touristAPI.getTourist(userId: reviewState.touristId) { tourist in
                        self.guideAPI.getGuide(guideId: reviewState.guideId) { guide in
                            let review = Review(reviewId: reviewState.reviewId, rating: reviewState.rating,
                                                comment: reviewState.comment ?? "No comment", guide: guide,
                                                trail: trail, createdAt: reviewState.createdAt ?? Date(),
                                                tourist: tourist)
                            reviews.append(review)
                            callback(reviews)
                        }
                    }
                }
            }
        }
    }
}
