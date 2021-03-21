//
//  BlogWriter.swift
//  Challo
//
//  Created by Ying Gao on 19/3/21.
//

import SwiftUI

struct BlogWriter: View {

    @ObservedObject var presenter: BlogWriterPresenter

    @State var draftSaved = false
    @State var draftPublished = false

    var body: some View {
        VStack {
            Text("Blog Writer")
                .font(.title)
                .foregroundColor(.primary)

            RoundedTextField(placeholder: "Title", text: $presenter.blogTitle, isPasswordField: false)
                .font(.title)

            RoundedTextEditor($presenter.blogBody, placeholder: "Enter text")

            ButtonsInHStack
        }
        .padding()

    }

    private var ButtonsInHStack: some View {
        HStack {
            SaveButton

            Spacer()

            PublishButton
        }
        .padding()
    }

    private var SaveButton: some View {
        BlogWriterButton(
            action: saveButtonDidTap,
            title: "Save Draft",
            color: buttonColor(disabled: presenter.savingDisabled)
        )
        .disabled(presenter.savingDisabled)
        .alert(isPresented: $draftSaved, content: {
            Alert(
                title: Text("Success!"),
                message: Text("Save Button tap has been registered"),
                dismissButton: .default(Text("Ok"), action: { draftSaved = false }))
        })
    }
    private var PublishButton: some View {
        BlogWriterButton(
            action: publishButtonDidTap,
            title: "Publish",
            color: buttonColor(disabled: presenter.publishingDisabled)
        )
        .disabled(presenter.publishingDisabled)
        .alert(isPresented: $draftPublished, content: {
            Alert(
                title: Text("Success!"),
                message: Text("Publish Button tap has been registered"),
                dismissButton: .default(Text("Ok"), action: { draftPublished = false }))
        })
    }

    private func buttonColor(disabled: Bool) -> Color {
        disabled ? .gray : .themePrimary
    }

    func saveButtonDidTap() {
        presenter.saveBlogDraft()
        draftSaved = true
    }

    func publishButtonDidTap() {
        presenter.publish()
        draftPublished = true
    }

}

struct BlogWriter_Preview: PreviewProvider {

    static var previews: some View {
        let (view, _) = BlogWriterModule.assemble()
        return view
    }

}
