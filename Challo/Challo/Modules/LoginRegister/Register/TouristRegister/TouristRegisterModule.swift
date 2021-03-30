//
//  TouristRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class TouristRegisterModule: ViperModuleProtocol {

    weak var userState: UserStateProtocol?
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func assemble() -> (view: AnyView, presenter: TouristRegisterPresenter) {
        guard let userState = userState else {
            fatalError("userState is nil in TouristRegisterModule")
        }
        
        let certManager = CertificateManager(userState: userState)
        let interactor = TouristRegisterInteractor(certificateManager: certManager)
        let presenter = TouristRegisterPresenter()
        let router = TouristRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginAPI = TouristLoginAPI()
        let registerAPI = TouristRegistrationAPI()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)

        let registerView = AnyView(TouristRegisterPage(registerPresenter: presenter,
                                                       socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
