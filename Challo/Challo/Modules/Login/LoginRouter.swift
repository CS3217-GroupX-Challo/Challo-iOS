//
//  LoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//
import SwiftUI

class LoginRouter: RouterProtocol {

    weak var presenter: LoginPresenter!

    func getRegistrationPage() -> some View {
        let (registerPage, _) = RegisterModule.assemble()
        return registerPage
    }
}
