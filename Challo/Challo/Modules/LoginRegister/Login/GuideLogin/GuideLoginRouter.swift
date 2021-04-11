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

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func getRegistrationPage() -> AnyView {
        GuideRegisterModule(userState: userState).assemble().view
    }
}
