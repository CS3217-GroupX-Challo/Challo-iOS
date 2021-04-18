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
    var bookingRepository: BookingRepositoryProtocol
    var bookingAPI: BookingAPIProtocol
    
    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingRepository: BookingRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         reviewAPI: ReviewAPIProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingRepository = bookingRepository
        self.bookingAPI = bookingAPI
        self.reviewAPI = reviewAPI
    }
    
    func assemble() -> (view: AnyView, presenter: TrailProfilePresenter) {
        let interactor = TrailProfileInteractor(reviewAPI: reviewAPI, userState: userState)
        let presenter = TrailProfilePresenter()
        let router = TrailProfileRouter(trailProfilePresenter: presenter,
                                        userState: userState,
                                        trailRepository: trailRepository,
                                        guideRepository: guideRepository,
                                        bookingRepository: bookingRepository,
                                        bookingAPI: bookingAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
