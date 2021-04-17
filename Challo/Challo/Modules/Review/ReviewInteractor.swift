//
//  ReviewInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

class ReviewInteractor: InteractorProtocol {

    weak var presenter: ReviewPresenter!

    private let reviewAPI: ReviewAPIProtocol
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }

    func submitReview(review: NewReview, onSubmission: @escaping (Bool, Error?) -> Void) {
        reviewAPI.submitNewReview(review: review, callback: onSubmission)
    }
}
