//
//  GuideProfilePagePresenter.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Combine

class GuideProfilePresenter: PresenterProtocol {
    var router: GuideProfileRouter?
    var interactor: GuideProfileInteractor!
    
    var guide: Guide
    @Published var reviews: [Review] = []
    
    init(guide: Guide) {
        self.guide = guide
        let reviewAPI = GuideProfilePresenter.createReviewAPI()
        self.interactor = GuideProfileInteractor(reviewAPI: reviewAPI)
        self.interactor.presenter = self
    }
    
    static func createReviewAPI() -> ReviewAPI {
        let networkManager = APINetwork.getNetworkManager()
        let trailAPI = TrailAPI(parser: TrailAPIParser(),
                                networkManager: networkManager)
        let touristAPI = TouristAPI(touristParser: TouristAPIParser(),
                                    networkManager: networkManager)
        let guideAPI = GuideAPI(guideParser: GuideAPIParser(),
                                trailParser: TrailAPIParser(),
                                networkManager: networkManager)
        
        return ReviewAPI(reviewParser: ReviewAPIParser(),
                         trailAPI: trailAPI,
                         touristAPI: touristAPI,
                         guideAPI: guideAPI,
                         networkManager: networkManager)
    }
}
