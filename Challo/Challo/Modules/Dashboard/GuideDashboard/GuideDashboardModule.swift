//
//  GuideDashboardModule.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI

class GuideDashboardModule: ViperModuleProtocol {

    private let userState: UserStateProtocol
    private let sendMessageToTourist: (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void
    private let bookingRepository: BookingRepositoryProtocol
    private let updateUserChat: (_ name: String, _ email: String) -> Void
    private let userAPI: UserAPIProtocol

    init(userState: UserStateProtocol,
         bookingRepository: BookingRepositoryProtocol,
         sendMessageToTourist: @escaping (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void,
         updateUserChat: @escaping (_ name: String, _ email: String) -> Void,
         userAPI: UserAPIProtocol) {
        self.userState = userState
        self.sendMessageToTourist = sendMessageToTourist
        self.bookingRepository = bookingRepository
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
    }

    func assemble() -> (view: AnyView, presenter: GuideDashboardPresenter) {
        let presenter = GuideDashboardPresenter(userState: userState,
                                                bookingRepository: bookingRepository)
        let interactor = GuideDashboardInteractor(userState: userState,
                                                  userAPI: userAPI,
                                                  updateUserChat: updateUserChat)
        let router = GuideDashboardRouter(userState: userState, bookingRepository: bookingRepository,
                                          sendMessageToTourist: sendMessageToTourist)
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        router.presenter = presenter
        let view = AnyView(GuideDashboardPage().environmentObject(presenter))
        return (view, presenter)
    }

}
