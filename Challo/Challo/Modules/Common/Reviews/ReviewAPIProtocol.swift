//
//  ReviewAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol ReviewAPIProtocol: APIProtocol {
    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void)
    
    func getReviewsForGuide(guideId: UUID, callback: @escaping ([Review]) -> Void)

    func submitReview(review: ReviewState, callback: @escaping ((Bool, Error?) -> Void))
}
