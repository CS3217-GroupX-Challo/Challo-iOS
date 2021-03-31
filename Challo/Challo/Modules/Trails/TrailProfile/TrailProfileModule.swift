//
//  TrailProfileModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfileModule: ViperModuleProtocol {

    var userState: UserStateProtocol
    var reviewAPI: ReviewAPIProtocol
    var trailRepository: TrailRepositoryProtocol
    var guideRepository: GuideRepositoryProtocol
    var bookingAPI: BookingAPIProtocol
    
    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         reviewAPI: ReviewAPIProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingAPI = bookingAPI
        self.reviewAPI = reviewAPI
    }
    
    func assemble() -> (view: AnyView, presenter: TrailProfilePresenter) {
        let interactor = TrailProfileInteractor(reviewAPI: reviewAPI)
        let presenter = TrailProfilePresenter(userState: userState)
        let router = TrailProfileRouter(trailProfilePresenter: presenter,
                                        userState: userState,
                                        trailRepository: trailRepository,
                                        guideRepository: guideRepository,
                                        bookingAPI: bookingAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
