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
    let areaRepository: AreaRepositoryProtocol
    let trailRepository: TrailRepositoryProtocol

    init(userState: UserStateProtocol,
         areaRepository: AreaRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.areaRepository = areaRepository
        self.trailRepository = trailRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideOnboardingPresenter) {
        let presenter = GuideOnboardingPresenter(userState: userState)
        let interactor = GuideOnboardingInteractor(userState: userState,
                                                   areaRepository: areaRepository,
                                                   trailRepository: trailRepository)
        let router = GuideOnboardingRouter()
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        let view = AnyView(Text("Placeholder"))
        return (view, presenter)
    }

}
