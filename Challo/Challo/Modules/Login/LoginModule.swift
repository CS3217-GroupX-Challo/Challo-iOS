//
//  LoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//
import SwiftUI

final class LoginModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: LoginPresenter) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(LoginPage(loginPresenter: presenter)), presenter: presenter)
    }
}
