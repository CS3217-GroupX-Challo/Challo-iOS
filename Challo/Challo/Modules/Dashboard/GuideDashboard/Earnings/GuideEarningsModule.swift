//
//  GuideEarningsModule.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import SwiftUI

final class GuideEarningsModule: ViperModuleProtocol {

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

    func assemble() -> (view: AnyView, presenter: GuideEarningsPresenter) {
        let presenter = GuideEarningsPresenter(userState: userState, sendMessageToTourist: sendMessageToTourist)
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
