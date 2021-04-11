//
//  RegisterButton.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import SwiftUI

struct RegisterButton<Presenter: RegisterPresenter>: View {

    var presenter: Presenter
    
    var body: some View {
        Button(action: presenter.submitRegistration) {
            Text("Sign up")
                .bold()
        }
        .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
    }
}
