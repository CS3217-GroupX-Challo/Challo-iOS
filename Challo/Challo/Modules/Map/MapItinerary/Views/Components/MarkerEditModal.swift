//
//  MarkerEditModal.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct MarkerEditModal: View {

    @State private var comments: String = "Test comment"
    @State private var selectedDate = Date()

    var body: some View {
        Card {
            VStack(alignment: .center) {
                DatePicker("Date", selection: $selectedDate)
                Text("Comments")
                    .font(.title2)
                    .foregroundColor(.themeSecondary)
                TextEditor(text: $comments)
                    .font(.body)
                    .foregroundColor(.themeSecondary)
                    .background(Color.themeBackground)
                    .border(Color.themeSecondary)
                    .frame(minWidth: 0,
                           maxWidth: 700,
                           minHeight: 0,
                           maxHeight: 500)
            }
            .padding()
        }
        .frame(width: .infinity,
               height: .infinity,
               alignment: .center)
    }
}

struct MarkerEditModal_Previews: PreviewProvider {
    static var previews: some View {
        MarkerEditModal()
    }
}
