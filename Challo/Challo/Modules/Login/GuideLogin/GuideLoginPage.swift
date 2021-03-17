//
//  GuidesLoginPage.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

struct GuideLoginPage: View {
    @ObservedObject var loginPresenter: LoginPresenter

    var body: some View {
        LoginRegisterBackground {
            GeometryReader { geometry in
                VStack {
                    ChalloTitle()
                    Card {
                        Text("Guides Login")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.themePrimary)
                        HStack {
                            loginPresenter.makeLoginWithFacebookButton()
                        }
                        LoginForm(email: $loginPresenter.email,
                                  password: $loginPresenter.password)
                        HStack {
                            loginPresenter.makeRegisterButton()
                            loginPresenter.makeLoginButton()
                        }
                    }
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: .center)
            }
        }
        .ignoresSafeArea()
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
