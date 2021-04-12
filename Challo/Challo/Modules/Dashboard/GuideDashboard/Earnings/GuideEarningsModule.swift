//
//  GuideDashboardModule.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import SwiftUI

final class GuideEarningsModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let bookingRepository: BookingRepositoryProtocol

    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideEarningsPresenter) {
        let presenter = GuideEarningsPresenter(userState: userState)
        let interactor = GuideEarningsInteractor(userState: userState, bookingRepository: bookingRepository)
        let router = GuideEarningsRouter()
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        let view = AnyView(GuideEarningsPage(presenter: presenter))
        return (view, presenter)
    }

}
