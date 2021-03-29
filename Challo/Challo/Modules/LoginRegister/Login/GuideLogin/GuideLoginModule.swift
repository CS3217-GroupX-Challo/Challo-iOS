//
//  GuidesLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class GuideLoginModule: ViperModuleProtocol {

    static func assemble(userState: UserStateProtocol) -> (view: AnyView, presenter: GuideLoginPresenter) {
        let certManager = CertificateManager(userState: userState)
        let interactor = GuideLoginInteractor(certificateManager: certManager)
        let presenter = GuideLoginPresenter()
        let router = GuideLoginRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
    
        let loginAPI = GuideLoginAPI()
        let registerAPI = GuideRegistrationAPI()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)
    
        return (view: AnyView(GuideLoginPage(loginPresenter: presenter,
                                             socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
