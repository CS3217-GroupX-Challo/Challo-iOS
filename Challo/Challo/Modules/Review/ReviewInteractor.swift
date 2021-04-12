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

    
    
}
