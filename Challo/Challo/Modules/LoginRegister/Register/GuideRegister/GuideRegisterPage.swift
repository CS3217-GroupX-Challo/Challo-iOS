//
//  GuideRegisterPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct GuideRegisterPage: View {

    @ObservedObject var registerPresenter: GuideRegisterPresenter
    var socialLoginPresenter: SocialLoginPresenter

    var body: some View {
        LoginRegisterContainer {
            ChalloEnterpriseTitle()
            Card {
                Text("Guides sign up")
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
        .alert(isPresented: $registerPresenter.isShowingRegisterSuccessAlert) {
            Alert(title: Text("Successfully signed up!"),
                  message: Text("You may now sign in with your account"),
                  dismissButton: .default(Text("Close")))
        }
    }
}
