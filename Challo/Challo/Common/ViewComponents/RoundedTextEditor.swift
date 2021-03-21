import SwiftUI

/**
 Text Editor with rounded edges that may or may not have placeholder text.
 Corner radius can be customised.
 */
struct RoundedTextEditor: View {

    private let placeholder: String
    private var cornerRadius: CGFloat

    @Binding private(set) var text: String

    init(_ text: Binding<String>, placeholder: String = "", cornerRadius: CGFloat = 25.0) {
        self.placeholder = placeholder
        self._text = text
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .autocapitalization(.sentences)
                .cornerRadius(cornerRadius)
                .padding()

            let textBox = text.isEmpty && !placeholder.isEmpty
                ? Text(placeholder).foregroundColor(.gray)
                : Text("")
            textBox.textFieldStyle(RoundedTextFieldStyle())
                .padding()
                .padding(.vertical)
        }
        .foregroundColor(.primary)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.themeTertiary, lineWidth: 2.0)
        )
        .padding()
    }
}

struct RoundedTextEditor_Preview: PreviewProvider {

    @State static var someText = ""

    static var previews: some View {
        let placeholder = "Enter text here"
        RoundedTextField(placeholder: placeholder, text: $someText)
    }

}
