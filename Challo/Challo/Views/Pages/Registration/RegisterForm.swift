import SwiftUI

struct RegisterForm: View {

    @State var username = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""

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
            RoundedTextField(placeholder: "Password", text: $password)
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        RegisterForm()
    }
}
