//
//  GuideRegisterPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct GuideRegisterPage: View {
    var loginPresenter: GuideLoginPresenter
    @ObservedObject var registerPresenter: GuideRegisterPresenter

    var body: some View {
        LoginRegisterContainer {
            ChalloEnterpriseTitle()
            Card {
                Text("Guides sign up")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.themePrimary)
                HStack {
                    loginPresenter.makeLoginWithFacebookButton()
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

struct GuideRegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = TouristRegisterModule.assemble()
        return view
    }
}
