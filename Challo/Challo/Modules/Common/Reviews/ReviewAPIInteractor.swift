//
//  ReviewAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

protocol ReviewAPIInteractor {
    typealias JSON = [String: Any]
    
    func parseReviews(response: JSON) -> [ReviewState]
}

extension ReviewAPIInteractor {
    func parseReviews(response: JSON) -> [ReviewState] {
        guard let data = response["data"],
              let reviewsInfo = data as? [JSON] else {
            return []
        }
        
        var reviewStates: [ReviewState] = []
        for reviewInfo in reviewsInfo {
            if let reviewState = convertJSONToReview(json: reviewInfo) {
                reviewStates.append(reviewState)
            }
        }
        return reviewStates
    }
    
    func convertJSONToReview(json: JSON) -> ReviewState? {
        guard let reviewId = UUID(uuidString: json[Key.reviewId] as? String ?? ""),
              let ratingString = json[Key.rating] as? String,
              let rating = Int(ratingString),
              let guideId = UUID(uuidString: json[Key.guideId] as? String ?? ""),
              let trailId = UUID(uuidString: json[Key.trailId] as? String ?? ""),
              let tourirstId = UUID(uuidString: json[Key.touristId] as? String ?? "") else {
            return nil
        }
        
        let comment: String? = json[Key.comment] as? String
        let createdAt: Date? = json[Key.createdAt] as? Date
        return ReviewState(reviewId: reviewId,
                           rating: rating,
                           comment: comment,
                           guideId: guideId,
                           touristId: tourirstId,
                           trailId: trailId,
                           createdAt: createdAt)
    }
}