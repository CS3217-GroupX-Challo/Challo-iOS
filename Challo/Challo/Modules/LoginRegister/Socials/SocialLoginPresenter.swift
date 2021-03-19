//
//  SocialLoginPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

import SwiftUI

class SocialLoginPresenter {

    var interactor: SocialLoginInteractor

    private init (interactor: SocialLoginInteractor) {
        self.interactor = interactor
    }

    static func createSocialLoginPresenter(loginLogic: LoginLogic,
                                           registrationLogic: RegistrationLogic) -> SocialLoginPresenter {
        let interactor = SocialLoginInteractor(loginLogic: loginLogic,
                                               registrationLogic: registrationLogic)
        return SocialLoginPresenter(interactor: interactor)
    }

    func makeLoginWithFacebookButton() -> AnyView {
        AnyView(FacebookLoginButton(action: interactor.loginWithFacebook))
    }
}
