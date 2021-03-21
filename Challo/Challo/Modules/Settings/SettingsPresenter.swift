//
//  SettingsPresenter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import Combine

class SettingsPresenter: PresenterProtocol, ObservableObject {
    var router: SettingsRouter?
    var interactor: SettingsInteractor!
    
    @Published var settingOptionViews: [SettingsListElement<AnyView>] = []
    var loggedInSettingOptions: [SettingsListElement<AnyView>] = []
    var loggedOutSettingOptions: [SettingsListElement<AnyView>] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private func toggleOptionsFrom(loggedInState loggedIn: Bool) {
        if loggedIn {
            settingOptionViews = loggedInSettingOptions
        } else {
            settingOptionViews = loggedOutSettingOptions
        }
    }
    
    func initializeSettingOptionsViews() {
        if let logOutButton = makeLogOutButton() {
            loggedInSettingOptions.append(logOutButton)
        }
        let loggedInSubscriber = UserState.globalState.$loggedIn.sink(receiveValue: toggleOptionsFrom)
        cancellables.insert(loggedInSubscriber)
        toggleOptionsFrom(loggedInState: UserState.globalState.loggedIn)
    }
    
    func onTapLogOut() {
        interactor.onTapLogOut()
    }
    
    func makeLogOutButton() -> SettingsListElement<AnyView>? {
        guard let loginPage = router?.getLoginPage() else {
            return nil
        }
        return SettingsListElement {
            AnyView(SettingsLogOutButton(loginPage: loginPage, presenter: self))
        }
    }
}
