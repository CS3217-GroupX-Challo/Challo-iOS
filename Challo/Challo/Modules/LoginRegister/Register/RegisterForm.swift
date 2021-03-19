import SwiftUI

struct RegisterForm: View {

    @Binding var name: String
    @Binding var phone: String
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack(spacing: 0) {
            RoundedTextField(placeholder: "Name", text: $name)
            RoundedTextField(placeholder: "Phone Number", text: $phone)
            RoundedTextField(placeholder: "Email Address", text: $email)
            RoundedTextField(placeholder: "Password",
                             text: $password,
                             isPasswordField: true)
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterForm(name: .constant("John"),
                     phone: .constant("12341234"),
                     email: .constant("john_doe@gmail.com"),
                     password: .constant("Strongpassword"))
    }
}
