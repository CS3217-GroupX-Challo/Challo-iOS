//
//  HomestayListingModule.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

final class HomestayListingModule: ViperModuleProtocol {
    let homestayRepository: HomestayRepositoryProtocol
    let userState: UserStateProtocol
    let sendMessageToHost: ((_ hostEmail: String, _ messageText: String) -> Void)

    init(userState: UserStateProtocol,
         homestayRepository: HomestayRepositoryProtocol,
         sendMessageToHost: @escaping ((_ hostEmail: String, _ messageText: String) -> Void)) {
        self.userState = userState
        self.homestayRepository = homestayRepository
        self.sendMessageToHost = sendMessageToHost
    }
    
    func assemble() -> (view: AnyView, presenter: HomestayListingPresenter) {
        let interactor = HomestayListingInteractor(homestayRepository: homestayRepository)
        let router = HomestayListingRouter(userState: userState,
                                           homestayRepository: homestayRepository,
                                           sendMessageToHost: sendMessageToHost)
        let presenter = HomestayListingPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(HomestayListingPage().environmentObject(presenter)), presenter: presenter)
    }
}
