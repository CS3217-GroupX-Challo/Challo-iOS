//
//  NavBarRouter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerRouter: RouterProtocol {
    
    weak var presenter: MainContainerPresenter!
    
    var profilePage: AnyView
    var trailsPage: AnyView
    var guidesPage: AnyView
    var mapsPage: AnyView
    var settingsPage: AnyView
    
    init(userState: UserStateProtocol) {
        profilePage = TouristLoginModule.assemble(userState: userState).view
        trailsPage = TrailListingModule.assemble(userState: userState).view
        guidesPage = GuidesListingModule.assemble(userState: userState).view
        mapsPage = MapModule.assemble(userState: userState).view
        settingsPage = SettingsModule.assemble(userState: userState).view
    }

}
