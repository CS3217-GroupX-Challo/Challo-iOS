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

    private let reviewParser: ReviewAPIParser
    private let trailAPI: TrailAPI
    private let touristAPI: TouristAPI
    private let guideAPI: GuideAPI
    private let networkManager: NetworkManager
    
    init(reviewParser: ReviewAPIParser, trailAPI: TrailAPI,
         touristAPI: TouristAPI, guideAPI: GuideAPI,
         networkManager: NetworkManager) {
        self.reviewParser = reviewParser
        self.trailAPI = trailAPI
        self.touristAPI = touristAPI
        self.guideAPI = guideAPI
        self.networkManager = networkManager
    }

    private func buildGetReviewsUrl(guideId: UUID?, trailId: UUID?) -> String {
        var hasQuery = false
        var url = "/review"
        if let guideId = guideId {
            url += "?guideId=\(guideId.uuidString)"
            hasQuery = true
        }
        if let trailId = trailId {
            url += (hasQuery ? "&" : "?") + "trailId=\(trailId.uuidString)"
        }
        return url
    }
    
    private func getReviews(callback: @escaping ([Review]) -> Void, guideId: UUID? = nil, trailId: UUID? = nil) {
        networkManager.get(url: buildGetReviewsUrl(guideId: guideId, trailId: trailId),
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
    
    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        getReviews(callback: callback, trailId: trailId)
    }
    
    func getReviewsForGuide(guideId: UUID, callback: @escaping ([Review]) -> Void) {
        getReviews(callback: callback, guideId: guideId)
    }
}
