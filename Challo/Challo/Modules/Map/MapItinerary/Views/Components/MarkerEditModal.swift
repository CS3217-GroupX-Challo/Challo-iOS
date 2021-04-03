//
//  MarkerEditModal.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct MarkerEditModal: View {

    @ObservedObject var presenter: MapItineraryPresenter
    @State private var comments: String
    @State private var selectedDate: Date
    
    init(presenter: MapItineraryPresenter) {
        self.presenter = presenter
        let initialComments = presenter.markerToEdit?.comments ?? "Enter your comments here!"
        let initialDate = presenter.markerToEdit?.date ?? Date()
        _comments = State(initialValue: initialComments)
        _selectedDate = State(initialValue: initialDate)
    }

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
                Button(action: {
                    presenter.endEdit(newDate: selectedDate, newComments: comments)
                }, label: {
                    Text("Save")
                })
            }
            .padding()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
    }
}
