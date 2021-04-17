//
//  SettingsRouter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

class SettingsRouter: RouterProtocol {
    weak var presenter: SettingsPresenter!
    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI

    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }
        
    func getLoginPage() -> AnyView {
        TouristLoginModule(userState: userState, loginAPI: loginAPI, registerAPI: registerAPI).assemble().view
    }
}
