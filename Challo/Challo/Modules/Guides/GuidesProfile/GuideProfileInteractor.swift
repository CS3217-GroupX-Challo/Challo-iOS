//
//  GuideProfilePageInteractor.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

class GuideProfileInteractor: InteractorProtocol {
    weak var presenter: GuideProfilePresenter!
    let reviewAPI: ReviewAPIProtocol
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }
    
    func getReviews() {
        presenter.isLoadingReviews = true
        reviewAPI.getReviewsForGuide(guideId: presenter.guide.userId) { [weak self] reviews in
            guard let self = self else {
                return
            }
            
            self.presenter.reviews = reviews
            self.presenter.isLoadingReviews = false
        }
    }
}
