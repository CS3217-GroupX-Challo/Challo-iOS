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
    
    init(userState: UserStateProtocol,
         homestayRepository: HomestayRepositoryProtocol) {
        self.userState = userState
        self.homestayRepository = homestayRepository
    }
    
    func assemble() -> (view: AnyView, presenter: HomestayProfilePresenter) {
        let interactor = HomestayProfileInteractor(userState: userState)
        let presenter = HomestayProfilePresenter()
        let router = HomestayProfileRouter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(HomestayProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
