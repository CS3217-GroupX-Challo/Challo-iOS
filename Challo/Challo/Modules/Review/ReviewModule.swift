//
//  ReviewModule.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

final class ReviewModule: ViperModuleProtocol {

    let reviewAPI: ReviewAPIProtocol
    let booking: Booking

    init(reviewAPI: ReviewAPIProtocol,
         booking: Booking) {
        self.reviewAPI = reviewAPI
        self.booking = booking
    }

    func assemble() -> (view: AnyView, presenter: ReviewPresenter) {
        let presenter = ReviewPresenter(booking: booking)
        let interactor = ReviewInteractor(reviewAPI: reviewAPI)
        let router = ReviewRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        interactor.presenter = presenter
        
        let reviewPage = AnyView(ReviewPage(presenter: presenter))
        return (view: reviewPage, presenter: presenter)
    }
}
