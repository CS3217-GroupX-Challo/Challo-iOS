//
//  GuideDashboardRouter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation
import SwiftUI

class GuideDashboardRouter: RouterProtocol {

    weak var presenter: GuideDashboardPresenter!
    let userState: UserStateProtocol
    let guideAPI: GuideAPIProtocol
    let trailRepository: TrailRepositoryProtocol

    init(userState: UserStateProtocol,
         guideAPI: GuideAPIProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.guideAPI = guideAPI
        self.trailRepository = trailRepository
    }

    func getOnboardingPage() -> AnyView {
        let onboardingModule = GuideOnboardingModule(userState: userState,
                                                     trailRepository: trailRepository,
                                                     guideAPI: guideAPI)
        return onboardingModule.assemble().view
    }

}
