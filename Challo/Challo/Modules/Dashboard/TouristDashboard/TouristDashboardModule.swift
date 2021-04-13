//
//  DashboardModule.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

final class TouristDashboardModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let bookingRepository: BookingRepositoryProtocol
    let reviewAPI: ReviewAPIProtocol
    let sendMessageToGuide: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)
    let updateUserChat: ((_ name: String, _ email: String) -> Void)
    let userAPI: UserAPIProtocol
    
    init(userState: UserStateProtocol, bookingsRepository: BookingRepositoryProtocol, reviewAPI: ReviewAPIProtocol,
         sendMessageToGuide: @escaping ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void),
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void),
         userAPI: UserAPIProtocol) {
        self.userState = userState
        self.bookingRepository = bookingRepository
        self.reviewAPI = reviewAPI
        self.sendMessageToGuide = sendMessageToGuide
        self.updateUserChat = updateUserChat
        self.userAPI = userAPI
    }

    func assemble() -> (view: AnyView, presenter: TouristDashboardPresenter) {
        let interactor = TouristDashboardInteractor(bookingsRepository: bookingsRepository,
                                                    userState: userState, userAPI: userAPI,
                                                    updateUserChat: updateUserChat)
        let router = TouristDashboardRouter(reviewAPI: reviewAPI)
        let presenter = TouristDashboardPresenter(userState: userState, sendMessageToGuide: sendMessageToGuide)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(TouristDashboardPage().environmentObject(presenter)), presenter: presenter)
    }
}
