//
//  LoginButton.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import SwiftUI

struct LoginButton<Presenter: LoginPresenter>: View {

    var presenter: Presenter

    var body: some View {
        Button(action: presenter.login) {
            Text("SIGN IN")
                .bold()
        }
        .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                         foregroundColor: .themePrimary))
    }
}
