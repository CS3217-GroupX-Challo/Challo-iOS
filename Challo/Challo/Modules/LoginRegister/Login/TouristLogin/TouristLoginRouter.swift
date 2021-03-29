//
//  TouristLoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class TouristLoginRouter: LoginRouter, RouterProtocol {

    weak var presenter: LoginPresenter!
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func getRegistrationPage() -> AnyView {
        TouristRegisterModule.assemble(userState: userState).view
    }
}
