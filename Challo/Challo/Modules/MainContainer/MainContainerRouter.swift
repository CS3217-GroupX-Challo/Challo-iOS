//
//  NavBarRouter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerRouter: RouterProtocol {
    
    weak var presenter: MainContainerPresenter!
    let userState: UserStateProtocol
    var apiContainer = APIContainer()
    var repositoryContainer: RepositoryContainer
    var profilePage: AnyView
    var trailsPage: AnyView
    var guidesPage: AnyView
    var mapsPage: AnyView
    var settingsPage: AnyView
    var loginPage: AnyView
    
    init(userState: UserStateProtocol) {
        self.userState = userState
        repositoryContainer = RepositoryContainer(apiContainer: apiContainer)
        
        guard let trailRepository = repositoryContainer.container.resolve(TrailRepositoryProtocol.self) else {
            fatalError("Failed to resolve trailRepository in MainContainer")
        }
        guard let guideRepository = repositoryContainer.container.resolve(GuideRepositoryProtocol.self) else {
            fatalError("Failed to resolve guideRepository in MainContainer")
        }
        guard let bookingRepository = repositoryContainer.container.resolve(BookingRepositoryProtocol.self) else {
            fatalError("Failed to resolve bookingAPI in MainContainer")
        }
        guard let reviewAPI = apiContainer.container.resolve(ReviewAPIProtocol.self) else {
            fatalError("Failed to resolve reviewAPI in MainContainer")
        }

        loginPage = GuideLoginModule(userState: userState).assemble().view
        trailsPage = TrailListingModule(trailRepository: trailRepository, reviewAPI: reviewAPI,
                                        userState: userState).assemble().view
        guidesPage = GuidesListingModule(guideRepository: guideRepository, reviewAPI: reviewAPI).assemble().view
        mapsPage = MapModule().assemble().view
        settingsPage = SettingsModule(userState: userState).assemble().view
        profilePage = GuideDashboardModule(userState: userState, bookingRepository: bookingRepository)
            .assemble().view
    }

}
