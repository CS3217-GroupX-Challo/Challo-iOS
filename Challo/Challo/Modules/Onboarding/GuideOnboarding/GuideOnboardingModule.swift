//
//  GuideOnboardingModule.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation
import SwiftUI

final class GuideOnboardingModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let trailRepository: TrailRepositoryProtocol

    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideOnboardingPresenter) {
        let presenter = GuideOnboardingPresenter(userState: userState)
        let interactor = GuideOnboardingInteractor(userState: userState,
                                                   trailRepository: trailRepository)
        let router = GuideOnboardingRouter()
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        let view = AnyView(GuideOnboardingPage(presenter: presenter))
        return (view, presenter)
    }

}
