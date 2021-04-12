//
//  GuideUpcomingBookingsModule.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation
import SwiftUI

class GuideUpcomingBookingsModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let repository: BookingRepositoryProtocol

    init(userState: UserStateProtocol, repository: BookingRepositoryProtocol) {
        self.userState = userState
        self.repository = repository
    }

    func assemble() -> (view: AnyView, presenter: GuideUpcomingBookingsPresenter) {
        let presenter = GuideUpcomingBookingsPresenter(userState: userState)
        let router = GuideUpcomingBookingsRouter()
        let interactor = GuideUpcomingBookingsInteractor(userState: userState, bookingRepository: repository)
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        return (AnyView(Text("Placeholder")), presenter)
    }
}
