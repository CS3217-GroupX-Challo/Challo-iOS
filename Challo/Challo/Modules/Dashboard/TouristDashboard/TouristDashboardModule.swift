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
    let sendMessageToGuide: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)
    
    init(userState: UserStateProtocol, bookingRepository: BookingRepositoryProtocol,
         sendMessageToGuide: @escaping ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.bookingRepository = bookingRepository
        self.sendMessageToGuide = sendMessageToGuide
    }

    func assemble() -> (view: AnyView, presenter: TouristDashboardPresenter) {
        let interactor = TouristDashboardInteractor(bookingsRepository: bookingRepository, userState: userState)
        let router = TouristDashboardRouter()
        let presenter = TouristDashboardPresenter(userState: userState, sendMessageToGuide: sendMessageToGuide)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(TouristDashboardPage().environmentObject(presenter)), presenter: presenter)
    }
}
