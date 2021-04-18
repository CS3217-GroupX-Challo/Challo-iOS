//
//  TrailProfileInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailProfileInteractor: EntityProfileInteractor {
    typealias Entity = Trail

    private let reviewAPI: ReviewAPIProtocol
    weak var presenter: TrailProfilePresenter!
    var userState: UserStateProtocol

    init(reviewAPI: ReviewAPIProtocol, userState: UserStateProtocol) {
        self.reviewAPI = reviewAPI
        self.userState = userState
    }

    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        reviewAPI.getReviewsForTrail(trailId: trailId, callback: callback)
    }
}
