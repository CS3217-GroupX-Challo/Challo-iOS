//
//  GuideProfilePageInteractor.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

class GuideProfileInteractor: InteractorProtocol {
    weak var presenter: GuideProfilePresenter!
    let reviewAPI: ReviewAPI
    
    init(reviewAPI: ReviewAPI) {
        self.reviewAPI = reviewAPI
    }
    
    func getReviews() {
        reviewAPI.getReviewsForGuide(guideId: presenter.guide.userId) { [weak self] reviews in
            guard let self = self else {
                return
            }
            
            self.presenter.reviews = reviews
        }
    }
}
