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
    #if GUIDE
    @Published var tabSelection = 0
    #elseif TOURIST
    @Published var tabSelection = 5
    #endif

    var interactor: MainContainerInteractor!
    var router: MainContainerRouter?
    let userState: UserStateProtocol
    
    private var cancellables: Set<AnyCancellable> = []

    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func initializeProfileTab() {
        guard let state = userState as? UserState else {
            return
        }

        state.$loggedIn.sink { [weak self] value in
            guard let self = self else {
                return
            }
            
            self.toggleLoggedIn(loggedInState: value)
        }.store(in: &cancellables)

        toggleLoggedIn(loggedInState: state.loggedIn)
    }

    private func toggleLoggedIn(loggedInState loggedIn: Bool) {
        self.profileTab = loggedIn ? router?.profilePage : router?.loginPage
    }

    func checkShouldDisplayUserDetails() -> Bool {
        interactor.checkIfUserLoggedIn()
    }

    func getSettingsPage() -> AnyView? {
        router?.settingsPage
    }

    func getProfilePage() -> AnyView? {
        profileTab
    }

    func getChatPage() -> AnyView? {
        router?.chatPage
    }

    #if TOURIST
    func getHomestayPage() -> AnyView? {
        router?.homestayPage
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
    #endif
    
    func goToChatPage() {
        #if TOURIST
        tabSelection = 4
        #elseif GUIDE
        tabSelection = 1
        #endif
    }
}
