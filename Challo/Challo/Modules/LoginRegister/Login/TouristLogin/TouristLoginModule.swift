//
//  TouristLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//
import SwiftUI

final class TouristLoginModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: TouristLoginPresenter) {
        let interactor = TouristLoginInteractor()
        let presenter = TouristLoginPresenter()
        let router = TouristLoginRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginLogic = TouristLoginLogic()
        let registerLogic = TouristRegistrationLogic()
        let socialInteractor = SocialLoginInteractor(loginLogic: loginLogic,
                                                     registrationLogic: registerLogic)
        let socialPresenter = SocialLoginPresenter()
        socialPresenter.interactor = socialInteractor

        return (view: AnyView(TouristLoginPage(loginPresenter: presenter, socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
