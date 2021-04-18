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
    @Published var isLoadingReviews = false
    
    init(guide: Guide, reviewAPI: ReviewAPIProtocol) {
        self.guide = guide
        self.interactor = GuideProfileInteractor(reviewAPI: reviewAPI)
        self.interactor.presenter = self
    }
}
