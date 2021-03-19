//
//  TouristRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class TouristRegisterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: TouristRegisterPresenter) {
        let interactor = TouristRegisterInteractor()
        let presenter = TouristRegisterPresenter()
        let router = TouristRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginLogic = TouristLoginLogic()
        let registerLogic = TouristRegistrationLogic()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginLogic: loginLogic, registrationLogic: registerLogic)

        let registerView = AnyView(TouristRegisterPage(registerPresenter: presenter,
                                                       socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
