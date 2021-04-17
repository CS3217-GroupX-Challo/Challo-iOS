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
    var sendMessageToTourist: ((_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void)

    init(userState: UserStateProtocol,
         bookingRepository: BookingRepositoryProtocol,
         sendMessageToTourist: @escaping ((_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.bookingRepository = bookingRepository
        self.sendMessageToTourist = sendMessageToTourist
    }

    func assemble() -> (view: AnyView, presenter: GuideUpcomingBookingsPresenter) {
        let presenter = GuideUpcomingBookingsPresenter(userState: userState, sendMessageToTourist: sendMessageToTourist)
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
