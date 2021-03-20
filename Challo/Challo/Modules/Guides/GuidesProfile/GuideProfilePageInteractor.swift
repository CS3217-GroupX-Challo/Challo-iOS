//
//  GuideProfilePageInteractor.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

class GuideProfilePageInteractor: InteractorProtocol {

    let reviewAPI = ReviewAPI()
    weak var presenter: GuideProfilePagePresenter!
    var networkManager = AlamofireManager.alamofireManager
    
    func getReviews() {
        reviewAPI.getReviewsForGuide(guideId: presenter.guide.userId) { [weak self] reviews in
            guard let self = self else {
                return
            }
            
            self.presenter.reviews = reviews
        }
    }
}
