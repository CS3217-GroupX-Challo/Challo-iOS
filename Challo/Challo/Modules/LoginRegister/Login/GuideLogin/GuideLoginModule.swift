//
//  GuidesLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class GuideLoginModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: GuideLoginPresenter) {
        let interactor = GuideLoginInteractor()
        let presenter = GuideLoginPresenter()
        let router = GuideLoginRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
    
        let loginLogic = GuideLoginLogic()
        let registerLogic = GuideRegistrationLogic()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginLogic: loginLogic, registrationLogic: registerLogic)
    
        return (view: AnyView(GuideLoginPage(loginPresenter: presenter,
                                             socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
