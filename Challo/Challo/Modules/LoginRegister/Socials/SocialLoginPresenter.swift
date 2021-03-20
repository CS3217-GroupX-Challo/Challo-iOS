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

    static func createSocialLoginPresenter(loginAPI: LoginAPI,
                                           registerAPI: RegisterAPI) -> SocialLoginPresenter {
        let interactor = SocialLoginInteractor(loginAPI: loginAPI,
                                               registerAPI: registerAPI)
        return SocialLoginPresenter(interactor: interactor)
    }

    func loginWithFacebook() {
        interactor.loginWithFacebook()
    }
}
