//
//  RegisterButton.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import SwiftUI

struct RegisterButton: View {

    var presenter: RegisterPresenter
    
    var body: some View {
        Button(action: presenter.submitRegistration) {
            Text("Sign up")
                .bold()
        }
        .buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
    }
}
