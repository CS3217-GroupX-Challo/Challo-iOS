//
//  TrailBookingModule.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import SwiftUI

final class TrailBookingModule: ViperModuleProtocol {

    private let trailProfilePresenter: TrailProfilePresenter
    private let trailRepository: TrailRepositoryProtocol
    private let guideRepository: GuideRepositoryProtocol
    private let bookingRepository: BookingRepositoryProtocol
    private let bookingAPI: BookingAPIProtocol
    private let userState: UserStateProtocol
    
    init(trailProfilePresenter: TrailProfilePresenter,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingRepository: BookingRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         userState: UserStateProtocol) {
        self.trailProfilePresenter = trailProfilePresenter
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingRepository = bookingRepository
        self.bookingAPI = bookingAPI
        self.userState = userState
    }

    func assemble() -> (view: AnyView, presenter: TrailBookingPresenter) {
        let interactor = TrailBookingInteractor(trailRepository: trailRepository,
                                                guideRepository: guideRepository,
                                                bookingRepository: bookingRepository,
                                                bookingAPI: bookingAPI,
                                                userState: userState)
        let presenter = TrailBookingPresenter()
        let router = TrailBookingRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailBookingPage(presenter: presenter)
                                .environmentObject(trailProfilePresenter)),
                presenter: presenter)
    }
}
