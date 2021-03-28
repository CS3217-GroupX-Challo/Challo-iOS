//
//  TouristLoginPage.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

struct TouristLoginPage: View {

    @ObservedObject var loginPresenter: TouristLoginPresenter
    var socialLoginPresenter: SocialLoginPresenter

    var body: some View {
        LoginRegisterContainer {
            ChalloTitle()
            Card {
                Text("Login")
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

struct TouristLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = TouristLoginModule.assemble(userState: UserState.sampleUserState)
        return view
    }
}
