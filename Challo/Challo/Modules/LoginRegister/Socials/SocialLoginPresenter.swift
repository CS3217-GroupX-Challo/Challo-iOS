//
//  SocialLoginPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

import SwiftUI

class SocialLoginPresenter {

    var interactor: SocialLoginInteractor!

    func makeLoginWithFacebookButton() -> AnyView {
        AnyView(FacebookLoginButton(action: interactor.loginWithFacebook))
    }
}
