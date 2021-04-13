//
//  SettingsModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class SettingsModule: ViperModuleProtocol {
    
    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI
    
    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }
    
    func assemble() -> (view: AnyView, presenter: SettingsPresenter) {
        let presenter = SettingsPresenter(userState: userState)
        let interactor = SettingsInteractor(userState: userState)
        let router = SettingsRouter(userState: userState, loginAPI: loginAPI, registerAPI: registerAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.initializeSettingOptionsViews()
        return (AnyView(SettingsPage().environmentObject(presenter)), presenter)
    }
}
