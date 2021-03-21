//
//  MainContainerPresenter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerPresenter: PresenterProtocol, ObservableObject {

    var interactor: MainContainerInteractor!
    var router: MainContainerRouter?

    func checkShouldDisplayUserDetails() -> Bool {
        interactor.checkIfUserLoggedIn()
    }
    
    func getProfilePage() -> AnyView? {
        router?.profilePage
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
