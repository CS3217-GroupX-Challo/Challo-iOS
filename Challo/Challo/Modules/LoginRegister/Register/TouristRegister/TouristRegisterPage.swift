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
        .alert(isPresented: $registerPresenter.isShowingRegisterAlert) {
            Alert(title: Text(registerPresenter.registerAlertTitle),
                  message: Text(registerPresenter.registerAlertMessage),
                  dismissButton: .default(Text("Close")))
        }
    }
}
