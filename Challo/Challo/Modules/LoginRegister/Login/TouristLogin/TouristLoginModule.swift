//
//  TouristLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//
import SwiftUI

final class TouristLoginModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    let loginAPI: LoginAPI
    let registerAPI: RegisterAPI
    
    init(userState: UserStateProtocol, loginAPI: LoginAPI, registerAPI: RegisterAPI) {
        self.userState = userState
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
    }
    
    func assemble() -> (view: AnyView, presenter: TouristLoginPresenter) {
        let certManager = CertificateManager(userState: userState)
        let interactor = TouristLoginInteractor(loginAPI: loginAPI, certificateManager: certManager)
        let presenter = TouristLoginPresenter()
        let router = TouristLoginRouter(userState: userState, loginAPI: loginAPI, registerAPI: registerAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)

        return (view: AnyView(TouristLoginPage(loginPresenter: presenter, socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
