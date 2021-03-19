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
                    socialLoginPresenter.makeLoginWithFacebookButton()
                }
                RegisterForm(name: $registerPresenter.name,
                             phone: $registerPresenter.phone,
                             email: $registerPresenter.email,
                             password: $registerPresenter.password)
                registerPresenter.makeRegisterButton()
            }
        }
        .alert(isPresented: $registerPresenter.isShowingRegisterFailureAlert) {
            Alert(title: Text("Unable to sign up"),
                  message: Text("Please check that you've filled in all your details"),
                  dismissButton: .default(Text("Close")))
        }
    }
}

struct TouristRegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = TouristRegisterModule.assemble()
        return view
    }
}
