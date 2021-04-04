//
//  GuidesLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class GuideLoginModule: ViperModuleProtocol {

    weak var userState: UserStateProtocol?
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: GuideLoginPresenter) {
        guard let userState = userState else {
            fatalError("userState is nil in GuideLoginModule")
        }
        
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
