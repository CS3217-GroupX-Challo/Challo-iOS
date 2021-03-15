//
//  RegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//
import SwiftUI

final class RegisterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: RegisterPresenter) {
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        let (_, loginPresenter) = LoginModule.assemble()
        let registerView = AnyView(RegisterPage(loginPresenter: loginPresenter, registerPresenter: presenter))
        return (view: registerView, presenter: presenter)
    }
}
