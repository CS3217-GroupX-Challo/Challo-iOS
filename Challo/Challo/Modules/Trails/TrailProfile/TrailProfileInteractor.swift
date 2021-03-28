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
        let networkManager = APINetwork.getNetworkManager()
        let trailAPI = TrailAPI(parser: TrailAPIParser(), networkManager: networkManager)
        let touristAPI = TouristAPI(touristParser: TouristAPIParser(), networkManager: networkManager)
        let guideAPI = GuideAPI(guideParser: GuideAPIParser(), trailParser: TrailAPIParser(),
                                networkManager: networkManager)
        
        let reviewAPI = ReviewAPI(reviewParser: ReviewAPIParser(), trailAPI: trailAPI,
                                  touristAPI: touristAPI, guideAPI: guideAPI,
                                  networkManager: networkManager)
        self.init(reviewAPI: reviewAPI)
    }

    func getReviewsForTrail(trailId: UUID, callback: @escaping ([Review]) -> Void) {
        reviewAPI.getReviewsForTrail(trailId: trailId, callback: callback)
    }
}
