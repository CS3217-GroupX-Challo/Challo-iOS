//
//  RegisterNavigationButton.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import SwiftUI

struct RegisterNavigationButton<Presenter: LoginPresenter>: View {

    var presenter: Presenter

    var body: some View {
        NavigationLink(destination: presenter.getRegistrationPage()) {
            Text("SIGN UP")
                .bold()
        }
        .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                         foregroundColor: .themePrimary))
    }
}
