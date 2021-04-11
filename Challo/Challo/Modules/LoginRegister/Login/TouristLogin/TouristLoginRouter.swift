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

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func getRegistrationPage() -> AnyView {
        TouristRegisterModule(userState: userState).assemble().view
    }
}
