//
//  TouristLoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class TouristLoginRouter: LoginRouter {

    weak var presenter: TouristLoginPresenter!
    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI

    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }

    func getRegistrationPage() -> AnyView {
        TouristRegisterModule(userState: userState, loginAPI: loginAPI, registerAPI: registerAPI).assemble().view
    }
}
