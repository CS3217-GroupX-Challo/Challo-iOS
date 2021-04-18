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

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

}
