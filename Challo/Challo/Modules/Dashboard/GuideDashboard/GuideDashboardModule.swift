//
//  GuideDashboardModule.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI

class GuideDashboardModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let sendMessageToTourist: (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void
    let bookingRepository: BookingRepositoryProtocol
    let trailRepository: TrailRepositoryProtocol
    let updateUserChat: (_ name: String, _ email: String) -> Void
    let userAPI: UserAPIProtocol
    let guideAPI: GuideAPIProtocol

    init(userState: UserStateProtocol,
         bookingRepository: BookingRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol,
         sendMessageToTourist: @escaping (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void,
         updateUserChat: @escaping (_ name: String, _ email: String) -> Void,
         userAPI: UserAPIProtocol,
         guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.sendMessageToTourist = sendMessageToTourist
        self.bookingRepository = bookingRepository
        self.trailRepository = trailRepository
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
        self.guideAPI = guideAPI
    }

    func assemble() -> (view: AnyView, presenter: GuideDashboardPresenter) {
        let presenter = GuideDashboardPresenter(userState: userState, bookingRepository: bookingRepository)
        let interactor = GuideDashboardInteractor(userState: userState,
                                                  userAPI: userAPI,
                                                  guideAPI: guideAPI,
                                                  updateUserChat: updateUserChat)
        let router = GuideDashboardRouter(userState: userState,
                                          guideAPI: guideAPI,
                                          bookingRepository: bookingRepository,
                                          trailRepository: trailRepository,
                                          sendMessageToTourist: sendMessageToTourist)
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        router.presenter = presenter
        let view = AnyView(GuideDashboardPage().environmentObject(presenter))
        return (view, presenter)
    }
}
