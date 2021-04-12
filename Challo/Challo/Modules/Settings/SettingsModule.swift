//
//  SettingsModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class SettingsModule: ViperModuleProtocol {
    
    let userState: UserStateProtocol
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    func assemble() -> (view: AnyView, presenter: SettingsPresenter) {
        let presenter = SettingsPresenter(userState: userState)
        let interactor = SettingsInteractor(userState: userState)
        let router = SettingsRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.initializeSettingOptionsViews()
        return (AnyView(SettingsPage().environmentObject(presenter)), presenter)
    }
}
