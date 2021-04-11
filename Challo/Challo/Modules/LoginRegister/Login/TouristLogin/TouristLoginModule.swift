//
//  TouristLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//
import SwiftUI

final class TouristLoginModule: ViperModuleProtocol {

    let userState: UserStateProtocol
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: TouristLoginPresenter) {
        guard let userState = userState else {
            fatalError("userState is nil in TouristLoginModule")
        }

        let certManager = CertificateManager(userState: userState)
        let interactor = TouristLoginInteractor(certificateManager: certManager)
        let presenter = TouristLoginPresenter()
        let router = TouristLoginRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginAPI = TouristLoginAPI()
        let registerAPI = TouristRegistrationAPI()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI, certificateManager: certManager)

        return (view: AnyView(TouristLoginPage(loginPresenter: presenter, socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
