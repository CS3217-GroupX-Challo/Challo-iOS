//
//  GuideRegisterRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterRouter: RegisterRouter {

    weak var presenter: GuideRegisterPresenter!

    private let userState: UserStateProtocol

    init(userState: UserStateProtocol, trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.trailRepository = trailRepository
    }

    private let trailRepository: TrailRepositoryProtocol
    var onboardingForm: AnyView {
        let onboardingModule = GuideOnboardingModule(userState: userState, trailRepository: trailRepository)
        return onboardingModule.assemble().view
    }

}
