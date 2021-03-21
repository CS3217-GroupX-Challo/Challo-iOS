//
//  TrailProfileInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailProfileInteractor: InteractorProtocol {

    private let reviewAPI: ReviewAPI
    weak var presenter: TrailProfilePresenter!

    init(reviewAPI: ReviewAPI) {
        self.reviewAPI = reviewAPI
    }

    convenience init() {
        self.init(reviewAPI: ReviewAPI())
    }

    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        reviewAPI.getReviewsForTrail(trailId: trailId, callback: callback)
    }
}
