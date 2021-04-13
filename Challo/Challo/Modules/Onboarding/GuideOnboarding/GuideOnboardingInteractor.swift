//
//  GuideOnboardingInteractor.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

class GuideOnboardingInteractor: InteractorProtocol {

    weak var presenter: GuideOnboardingPresenter!

    var areaRepository: AreaRepositoryProtocol
    var guideRepository: GuideRepositoryProtocol
    var trailRepository: TrailRepositoryProtocol

    init(areaRepository: AreaRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol) {
        self.areaRepository = areaRepository
        self.guideRepository = guideRepository
        self.trailRepository = trailRepository
    }

    var trails = [Trail]()
    
}
