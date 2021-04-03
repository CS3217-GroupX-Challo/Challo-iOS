//
//  TrailListingModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingModule: ViperModuleProtocol {
    
    let trailRepository: TrailRepositoryProtocol
    let guideRepository: GuideRepositoryProtocol
    let reviewAPI: ReviewAPIProtocol
    let bookingAPI: BookingAPIProtocol
    let userState: UserStateProtocol
    
    init(trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         reviewAPI: ReviewAPIProtocol,
         userState: UserStateProtocol) {
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingAPI = bookingAPI
        self.reviewAPI = reviewAPI
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: TrailListingPresenter) {
        let interactor = TrailListingInteractor(trailRepository: trailRepository)
        let presenter = TrailListingPresenter()
        let router = TrailListingRouter(userState: userState,
                                        trailRepository: trailRepository,
                                        guideRepository: guideRepository,
                                        bookingAPI: bookingAPI,
                                        reviewAPI: reviewAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailListingPage().environmentObject(presenter)), presenter: presenter)
    }
}
