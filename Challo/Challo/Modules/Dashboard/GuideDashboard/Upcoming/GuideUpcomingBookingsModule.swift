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
    let bookingRepository: BookingRepositoryProtocol

    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideUpcomingBookingsPresenter) {
        let presenter = GuideUpcomingBookingsPresenter(userState: userState)
        let router = GuideUpcomingBookingsRouter()
        let interactor = GuideUpcomingBookingsInteractor(userState: userState, bookingRepository: bookingRepository)
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.presenter = presenter
        let view = GuideUpcomingBookingsPage(presenter: presenter)
        return (AnyView(view), presenter)
    }
}
