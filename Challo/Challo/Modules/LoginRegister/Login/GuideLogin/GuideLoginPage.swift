//
//  GuidesLoginPage.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

struct GuideLoginPage: View {

    @ObservedObject var loginPresenter: GuideLoginPresenter
    var socialLoginPresenter: SocialLoginPresenter

    var body: some View {
        LoginRegisterContainer {
            ChalloEnterpriseTitle()
            Card {
                Text("Guides Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.themePrimary)
                HStack {
                    FacebookLoginButton(action: socialLoginPresenter.loginWithFacebook)
                }
                LoginForm(email: $loginPresenter.email,
                          password: $loginPresenter.password)
                HStack {
                    RegisterNavigationButton(presenter: loginPresenter)
                    LoginButton(presenter: loginPresenter)
                }
            }
        }
        .alert(isPresented: $loginPresenter.isShowingLoginFailureAlert) {
            Alert(title: Text("Unable to sign in"),
                  message: Text("Please check your email and password again"),
                  dismissButton: .default(Text("Close")))
        }
    }
}

struct GuideLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = GuideLoginModule.assemble()
        return view
    }
}
