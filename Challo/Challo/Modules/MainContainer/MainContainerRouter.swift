//
//  NavBarRouter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerRouter: RouterProtocol {
    
    weak var presenter: MainContainerPresenter!
    var userState = UserState.globalState
    
    var profilePage: AnyView
    var trailsPage: AnyView
    var guidesPage: AnyView
    var mapsPage: AnyView
    var settingsPage: AnyView
    
    init() {
        profilePage = TouristLoginModule.assemble().view
        trailsPage = TrailListingModule.assemble().view
        guidesPage = GuidesListingModule.assemble().view
        mapsPage = MapModule.assemble().view
        settingsPage = SettingsModule.assemble().view
    }

}
