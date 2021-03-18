//
//  GuidesLoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class GuideLoginRouter: LoginRouter, RouterProtocol {

    weak var presenter: LoginPresenter!

    func getRegistrationPage() -> AnyView {
        let (registerPage, _) = GuideRegisterModule.assemble()
        return registerPage
    }
}
