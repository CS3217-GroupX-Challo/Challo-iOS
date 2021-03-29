//
//  GuideRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterModule: ViperModuleProtocol {

    weak var userState: UserStateProtocol?
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: GuideRegisterPresenter) {
        guard let userState = userState else {
            fatalError("userState is nil in GuideRegisterModule")
        }
        
        let certManager = CertificateManager(userState: userState)
        let interactor = GuideRegisterInteractor(certificateManager: certManager)
        let presenter = GuideRegisterPresenter()
        let router = GuideRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginAPI = GuideLoginAPI()
        let registerAPI = GuideRegistrationAPI()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)
    
        let registerView = AnyView(GuideRegisterPage(registerPresenter: presenter,
                                                     socialLoginPresenter: socialPresenter))
        return (view: registerView, presenter: presenter)
    }
}
