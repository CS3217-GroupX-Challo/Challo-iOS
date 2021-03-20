//
//  LoginForm.swift
//  Challo
//
//  Created by Tan Le Yang on 14/3/21.
//

import SwiftUI

struct LoginForm: View {

    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack {
            RoundedTextField(placeholder: "Email", text: $email)
            RoundedTextField(placeholder: "Password",
                             text: $password,
                             isPasswordField: true)
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(email: .constant(""),
                  password: .constant("123"))
    }
}
