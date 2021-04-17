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
        let areaConvertor = AreaModelConvertor()
        let trailConvertor = TrailModelConvertor(convertor: areaConvertor)
        let guideConvertor = GuideModelConvertor(areaModelConvertor: areaConvertor,
                                                 trailModelConvertor: trailConvertor)
        let reviewConvertor = ReviewModelConvertor(guideModelConvertor: guideConvertor,
                                                   touristModelConvertor: TouristModelConvertor(),
                                                   trailModelConvertor: trailConvertor)
        let reviewStore = ReviewStore(repository: AnyPersistenceRepoProtocol(ReviewDetailsRepository()),
                                      convertor: reviewConvertor)
        reviewAPI.getReviewsForGuide(guideId: presenter.guide.userId) { [weak self] reviews in
            guard let self = self else {
                return
            }
            
            self.presenter.reviews = reviews
            reviewStore.save(models: reviews)
            let localReviews = reviewStore.getAll()
        }
    }
}
