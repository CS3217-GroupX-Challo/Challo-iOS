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
    
    init() {
        profilePage = TouristLoginModule.assemble().view
        trailsPage = TrailListingModule.assemble().view
        guidesPage = GuidesModule.assemble().view
    }

}
