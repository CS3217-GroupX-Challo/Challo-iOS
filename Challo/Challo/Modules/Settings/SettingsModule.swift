//
//  SettingsModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class SettingsModule: ViperModuleProtocol {
    func assemble() -> (view: AnyView, presenter: SettingsPresenter) {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.initializeSettingOptionsViews()
        return (AnyView(SettingsPage().environmentObject(presenter)), presenter)
    }
}
