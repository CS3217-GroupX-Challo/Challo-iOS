//
//  GuideRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI
    
    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }
    
    func assemble() -> (view: AnyView, presenter: GuideRegisterPresenter) {
        let certManager = CertificateManager(userState: userState)
        let interactor = GuideRegisterInteractor(registerAPI: registerAPI, certificateManager: certManager)
        let presenter = GuideRegisterPresenter()
        let router = GuideRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)
    
        let registerView = AnyView(GuideRegisterPage(registerPresenter: presenter,
                                                     socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
