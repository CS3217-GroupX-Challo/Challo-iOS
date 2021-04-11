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

    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideDashboardPresenter) {
        guard let userState = userState else {
            fatalError("userState must not be nil")
        }
        let presenter = GuideDashboardPresenter(userState: userState)
        let interactor = GuideDashboardInteractor(userState: userState, bookingRepository: bookingRepository)
        let router = GuideDashboardRouter()
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        let view = AnyView(GuideDashboardPage(presenter: presenter))
        return (view, presenter)
    }

}
