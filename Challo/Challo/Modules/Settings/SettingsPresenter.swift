//
//  SettingsPresenter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//
import SwiftUI

class SettingsPresenter: PresenterProtocol {
    var router: SettingsRouter?
    var interactor: SettingsInteractor!
    
    var settingOptionViews: [SettingsListElement<AnyView>] = []
    
    func initializeSettingOptionsViews() {
        guard let settingsRouter = router else {
            return
        }
        
        settingOptionViews.append(settingsRouter.makeLogOutButton())
    }
}
