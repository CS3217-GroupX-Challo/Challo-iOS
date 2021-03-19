//
//  ReviewAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

/// It conforms to trail API and UserAPI as data from reviewAPI is dependent on
/// the two APIs aforementioned
protocol ReviewAPI: ReviewAPIInteractor, TrailAPI, UserAPI, GuideAPI {
    func getReviewsForGuide(guideId: UUID, callback: @escaping ([Review]) -> Void, url: String)
}

extension ReviewAPI {
    func getReviewsForGuide(guideId: UUID,
                            callback: @escaping ([Review]) -> Void,
                            url: String = "/review?guideId=") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + guideId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            let reviewStates: [ReviewState] = parseReviews(response: response)
            var reviews: [Review] = []
            for reviewState in reviewStates {
                getTrail(trailId: reviewState.trailId) { trail in
                    getTourist(userId: reviewState.touristId) { tourist in
                        getGuide(guideId: reviewState.guideId) { guide in
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
