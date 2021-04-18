//
//  HomestayProfileModule.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

class HomestayProfileModule: ViperModuleProtocol {

    var userState: UserStateProtocol
    var homestayRepository: HomestayRepositoryProtocol
    let sendMessageToHost: ((_ hostEmail: String, _ messageText: String) -> Void)
    
    init(userState: UserStateProtocol,
         homestayRepository: HomestayRepositoryProtocol,
         sendMessageToHost: @escaping ((_ hostEmail: String, _ messageText: String) -> Void)) {
        self.userState = userState
        self.homestayRepository = homestayRepository
        self.sendMessageToHost = sendMessageToHost
    }
    
    func assemble() -> (view: AnyView, presenter: HomestayProfilePresenter) {
        let interactor = HomestayProfileInteractor(userState: userState, sendMessageToHost: sendMessageToHost)
        let presenter = HomestayProfilePresenter()
        let router = HomestayProfileRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(HomestayProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
