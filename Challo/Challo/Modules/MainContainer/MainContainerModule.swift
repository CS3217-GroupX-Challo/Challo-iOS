//
//  MainContainerModule.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerModule: ViperModuleProtocol {

    weak var userState: UserStateProtocol?
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: MainContainerPresenter) {
        guard let userState = userState else {
            fatalError("userState is not initialised")
        }
        let interactor = MainContainerInteractor(userState: userState)
        let presenter = MainContainerPresenter(userState: userState)
        let router = MainContainerRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.initializeProfileTab()
        return (view: AnyView(MainContainerView().environmentObject(presenter)),
                presenter: presenter)
    }
}
