//
//  MainContainerPresenter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI
import Combine

class MainContainerPresenter: PresenterProtocol, ObservableObject {

    @Published var profileTab: AnyView?
    @Published var tabSelection = 0

    var interactor: MainContainerInteractor!
    var router: MainContainerRouter?
    unowned let userState: UserStateProtocol!
    
    private var cancellables: Set<AnyCancellable> = []

    init(userState: UserStateProtocol) {
        self.userState = userState
        initializeProfileTab()
    }
    
    func initializeProfileTab() {
        guard let state = userState as? UserState else {
            return
        }
        let loggedInSubscriber = state.$loggedIn.sink(receiveValue: toggleLoggedIn)
        cancellables.insert(loggedInSubscriber)
        toggleLoggedIn(loggedInState: state.loggedIn)
    }

    private func toggleLoggedIn(loggedInState loggedIn: Bool) {
        self.profileTab = loggedIn ? router?.profilePage : router?.loginPage
    }

    func checkShouldDisplayUserDetails() -> Bool {
        interactor.checkIfUserLoggedIn()
    }
    
    func getProfilePage() -> AnyView? {
        profileTab
    }
    
    func getTrailPage() -> AnyView? {
        router?.trailsPage
    }
    
    func getGuidePage() -> AnyView? {
        router?.guidesPage
    }
    
    func getMapsPage() -> AnyView? {
        router?.mapsPage
    }
    
    func getSettingsPage() -> AnyView? {
        router?.settingsPage
    }
}
