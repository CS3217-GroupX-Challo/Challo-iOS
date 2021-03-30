//
//  TouristRegisterPage.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

struct TouristRegisterPage: View {

    @ObservedObject var registerPresenter: TouristRegisterPresenter
    var socialLoginPresenter: SocialLoginPresenter

    var body: some View {
        LoginRegisterContainer {
            ChalloTitle()
            Card {
                Text("Sign up")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.themePrimary)
                HStack {
                    FacebookLoginButton(action: socialLoginPresenter.loginWithFacebook)
                }
                RegisterForm(name: $registerPresenter.name,
                             phone: $registerPresenter.phone,
                             email: $registerPresenter.email,
                             password: $registerPresenter.password)
                RegisterButton(presenter: registerPresenter)
            }
        }
        .alert(isPresented: $registerPresenter.isShowingRegisterFailureAlert) {
            Alert(title: Text("Unable to sign up"),
                  message: Text("Please check that you've filled in all your details"),
                  dismissButton: .default(Text("Close")))
        }
        .alert(isPresented: $registerPresenter.isShowingRegisterSuccessAlert) {
            Alert(title: Text("Successfully signed up!"),
                  message: Text("You may now sign in with your account"),
                  dismissButton: .default(Text("Close")))
        }
    }
}
