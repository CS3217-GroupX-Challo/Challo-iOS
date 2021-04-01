//
//  DashboardModule.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

final class TouristDashboardModule: ViperModuleProtocol {

    weak var userState: UserStateProtocol?
    let bookingsRepository: BookingRepositoryProtocol
    
    init(userState: UserStateProtocol, bookingsRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.bookingsRepository = bookingsRepository
    }

    func assemble() -> (view: AnyView, presenter: TouristDashboardPresenter) {
        guard let userState = userState else {
            fatalError("userState is nil in TouristDashboardModule")
        }
        let interactor = TouristDashboardInteractor(bookingsRepository: bookingsRepository, userState: userState)
        let router = TouristDashboardRouter()
        let presenter = TouristDashboardPresenter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(TouristDashboardPage(presenter: presenter)), presenter: presenter)
    }
}
