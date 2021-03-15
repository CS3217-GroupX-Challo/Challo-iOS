//
//  LoginRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//
import SwiftUI

class LoginRouter {

    func getRegistrationPage() -> some View {
        RegisterPage(loginPresenter: LoginPresenter(interactor: LoginInteractor()),
                     registerPresenter: RegisterPresenter(interactor: RegisterInteractor()))
    }
}
