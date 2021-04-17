//
//  TouristRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class TouristRegisterModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI
    
    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }

    func assemble() -> (view: AnyView, presenter: TouristRegisterPresenter) {
        let certManager = CertificateManager(userState: userState)
        let interactor = TouristRegisterInteractor(registerAPI: registerAPI, certificateManager: certManager)
        let presenter = TouristRegisterPresenter()
        let router = TouristRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)

        let registerView = AnyView(TouristRegisterPage(registerPresenter: presenter,
                                                       socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
