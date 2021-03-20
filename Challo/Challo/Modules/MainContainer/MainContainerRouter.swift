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
        profilePage = AnyView(Text("MOCK HOMEPAGE"))
        trailsPage = TrailListingModule.assemble().view
        guidesPage = GuidesModule.assemble().view
        print("init main cont router")
    }
    
    func getProfileView() -> AnyView {
//        if !userState.loggedIn {
//            let (loginPage, _) = TouristLoginModule.assemble()
//            return loginPage
//        } else {
            return AnyView(Text("MOCK HOMEPAGE"))
//        }
    }

}
