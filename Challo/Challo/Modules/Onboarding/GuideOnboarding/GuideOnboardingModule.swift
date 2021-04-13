//
//  GuideOnboardingModule.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation
import SwiftUI

final class GuideOnboardingModule: ViperModuleProtocol {

    let areaRepository: AreaRepositoryProtocol
    let guideRepository: GuideRepositoryProtocol
    let trailRepository: TrailRepositoryProtocol

    init(areaRepository: AreaRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.areaRepository = areaRepository
        self.guideRepository = guideRepository
        self.trailRepository = trailRepository
    }

    func assemble() -> (view: AnyView, presenter: GuideOnboardingPresenter) {
        let presenter = GuideOnboardingPresenter()
        let interactor = GuideOnboardingInteractor(areaRepository: areaRepository,
                                                   guideRepository: guideRepository,
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
