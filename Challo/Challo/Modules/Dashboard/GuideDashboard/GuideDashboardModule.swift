//
//  GuideDashboardModule.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import SwiftUI

final class GuideDashboardModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let bookingRepository: BookingRepositoryProtocol
    let trailRepository: TrailRepositoryProtocol
    let guideAPI: GuideAPIProtocol

    init(userState: UserStateProtocol,
         bookingRepository: BookingRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
        self.trailRepository = trailRepository
        self.guideAPI = guideAPI
    }

    func assemble() -> (view: AnyView, presenter: GuideDashboardPresenter) {
        let presenter = GuideDashboardPresenter(userState: userState)
        let interactor = GuideDashboardInteractor(userState: userState,
                                                  bookingRepository: bookingRepository,
                                                  guideAPI: guideAPI)
        let router = GuideDashboardRouter(userState: userState,
                                          guideAPI: guideAPI,
                                          trailRepository: trailRepository)
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        let view = AnyView(GuideDashboardPage(presenter: presenter))
        return (view, presenter)
    }
}
