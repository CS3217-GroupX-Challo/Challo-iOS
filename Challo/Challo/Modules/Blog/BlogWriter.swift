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
            BlogWriterButton(action: presenter.saveBlogDraft, title: "Save Draft")
                .disabled(presenter.savingDisabled)

            Spacer()

            BlogWriterButton(action: presenter.publish, title: "Publish")
                .disabled(presenter.publishingDisabled)
        }
        .padding()
    }

}

struct BlogWriter_Preview: PreviewProvider {

    static var previews: some View {
        let (view, _) = BlogWriterModule.assemble()
        return view
    }

}
