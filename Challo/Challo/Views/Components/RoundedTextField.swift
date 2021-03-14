import SwiftUI

struct RoundedTextField: View {

    var placeholder: String?
    var text: Binding<String>
    var isPasswordField = false

    var body: some View {
        if isPasswordField {
            SecureField(placeholder ?? "",
                               text: text)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding()
        } else {
            TextField(placeholder ?? "",
                             text: text)
                .textFieldStyle(RoundedTextFieldStyle())
                .padding()
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField(text: .constant("Test"))
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .shadow(color: .gray, radius: 10)
    }
}

