//
//  TrailProfileInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailProfileInteractor: InteractorProtocol {

    private let reviewAPI: ReviewAPIProtocol
    weak var presenter: TrailProfilePresenter!

    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }

    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        reviewAPI.getReviewsForTrail(trailId: trailId, callback: callback)
    }
}
