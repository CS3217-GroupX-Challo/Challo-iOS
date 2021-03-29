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
    
    var apiContainer = APIContainer()
    var repositoryContainer: RepositoryContainer
    var profilePage: AnyView
    var trailsPage: AnyView
    var guidesPage: AnyView
    var mapsPage: AnyView
    var settingsPage: AnyView
    
    init() {
        repositoryContainer = RepositoryContainer(apiContainer: apiContainer)
        
        guard let trailRepository = repositoryContainer.container.resolve(TrailRepositoryProtocol.self) else {
            fatalError("Failed to resolve trailRepository in MainContainer")
        }
        guard let guideRepository = repositoryContainer.container.resolve(GuideRepositoryProtocol.self) else {
            fatalError("Failed to resolve guideRepository in MainContainer")
        }
        guard let reviewAPI = apiContainer.container.resolve(ReviewAPIProtocol.self) else {
            fatalError("Failed to resolve reviewAPI in MainContainer")
        }
        
        profilePage = TouristLoginModule().assemble().view
        trailsPage = TrailListingModule(trailRepository: trailRepository, reviewAPI: reviewAPI).assemble().view
        guidesPage = GuidesListingModule(guideRepository: guideRepository, reviewAPI: reviewAPI).assemble().view
        mapsPage = MapModule().assemble().view
        settingsPage = SettingsModule().assemble().view
    }

}
