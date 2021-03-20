//
//  LoginButton.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import SwiftUI

struct LoginButton: View {

    var presenter: LoginPresenter

    var body: some View {
        Button(action: presenter.login) {
            Text("SIGN IN")
                .bold()
        }
        .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                         foregroundColor: .themePrimary))
    }
}
