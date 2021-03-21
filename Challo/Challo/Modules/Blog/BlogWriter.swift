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
        .alert(isPresented: $presenter.savingEnabled, content: {
            Alert(title: Text("Not so fast!"),
                  message: Text("Your post needs to at least have a title!"),
                  dismissButton: .default(Text("Ok")))
        })
    }

    private var buttons: some View {
        HStack {
            BlogWriterButton(action: presenter.saveBlogDraft, title: "Save Draft")

            Spacer()

            BlogWriterButton(action: presenter.publish, title: "Publish")
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
