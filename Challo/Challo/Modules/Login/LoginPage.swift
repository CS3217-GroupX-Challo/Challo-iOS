//
//  LoginPage.swift
//  Challo
//
//  Created by Tan Le Yang on 14/3/21.
//

import SwiftUI

struct LoginPage: View {
    @ObservedObject var loginPresenter: LoginPresenter

    var body: some View {
        LoginRegisterBackground {
            GeometryReader { geometry in
                VStack {
                    ChalloTitle()
                    Card {
                        Text("Login")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.themePrimary)
                        HStack {
                            loginPresenter.makeLoginWithFacebookButton()
                        }
                        LoginForm()
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
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = LoginModule.assemble()
        return view
    }
}
