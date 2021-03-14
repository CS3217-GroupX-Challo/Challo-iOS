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
        ZStack {
            GeometryReader { geometry in
                Card {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                    HStack {
                        loginPresenter.makeLoginWithFacebookButton()
                    }
                    LoginForm()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Done")
                            .foregroundColor(.yellow)
                            .bold()
                    })
                    .buttonStyle(RoundedCornerButton(color: Color.black))
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(loginPresenter: LoginPresenter(interactor: LoginInteractor()))
    }
}
