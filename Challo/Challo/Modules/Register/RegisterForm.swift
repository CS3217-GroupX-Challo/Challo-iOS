import SwiftUI

struct RegisterForm: View {

    @Binding var username: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack(spacing: 0) {
            RoundedTextField(placeholder: "Username", text: $username)
            HStack(spacing: 0) {
                RoundedTextField(placeholder: "First Name",
                                 text: $firstName)
                RoundedTextField(placeholder: "Last Name",
                                 text: $lastName)
            }
            RoundedTextField(placeholder: "Email Address", text: $email)
            RoundedTextField(placeholder: "Password",
                             text: $password,
                             isPasswordField: true)
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterForm(username: .constant("Hello"),
                     firstName: .constant("John"),
                     lastName: .constant("Doe"),
                     email: .constant("john_doe@gmail.com"),
                     password: .constant("Strongpassword"))
    }
}
