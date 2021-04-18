//
//  GuidesLoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class GuideLoginRouter: LoginRouter {

    weak var presenter: GuideLoginPresenter!
    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI
    let trailRepository: TrailRepositoryProtocol
    
    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI,
         trailRepository: TrailRepositoryProtocol) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
        self.trailRepository = trailRepository
    }

    func getRegistrationPage() -> AnyView {
        GuideRegisterModule(userState: userState,
                            loginAPI: loginAPI,
                            registerAPI: registerAPI,
                            trailRepository: trailRepository).assemble().view
    }
}
