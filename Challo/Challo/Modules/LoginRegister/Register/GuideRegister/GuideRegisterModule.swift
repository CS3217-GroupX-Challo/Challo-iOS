//
//  GuideRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: GuideRegisterPresenter) {
        let interactor = GuideRegisterInteractor()
        let presenter = GuideRegisterPresenter()
        let router = GuideRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginLogic = GuideLoginLogic()
        let registerLogic = GuideRegistrationLogic()
        let socialInteractor = SocialLoginInteractor(loginLogic: loginLogic,
                                                     registrationLogic: registerLogic)
        let socialPresenter = SocialLoginPresenter()
        socialPresenter.interactor = socialInteractor
    
        let registerView = AnyView(GuideRegisterPage(registerPresenter: presenter,
                                                     socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
