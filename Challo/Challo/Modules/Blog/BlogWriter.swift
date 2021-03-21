//
//  BlogWriter.swift
//  Challo
//
//  Created by Ying Gao on 19/3/21.
//

import SwiftUI

struct BlogWriter: View {

    @ObservedObject var presenter: BlogWriterPresenter

    var body: some View {
        VStack {
            Text("Blog Writer")
                .font(.title)
                .foregroundColor(.primary)

            RoundedTextField(placeholder: "Title", text: $presenter.blogTitle, isPasswordField: false)
                .font(.title)

            RoundedTextEditor($presenter.blogBody, placeholder: "Enter text")

            buttons
        }
        .padding()

    }

    private var buttons: some View {
        HStack {
            let savingDisabled = presenter.savingDisabled
            BlogWriterButton(
                action: presenter.saveBlogDraft,
                title: "Save Draft",
                color: buttonColor(disabled: savingDisabled)
            )
            .disabled(savingDisabled)

            Spacer()

            let publishingDisabled = presenter.publishingDisabled
            BlogWriterButton(
                action: presenter.publish,
                title: "Publish",
                color: buttonColor(disabled: publishingDisabled)
            )
            .disabled(publishingDisabled)
        }
        .padding()
    }

    private func buttonColor(disabled: Bool) -> Color {
        disabled ? .gray : .themePrimary
    }

}

struct BlogWriter_Preview: PreviewProvider {

    static var previews: some View {
        let (view, _) = BlogWriterModule.assemble()
        return view
    }

}
