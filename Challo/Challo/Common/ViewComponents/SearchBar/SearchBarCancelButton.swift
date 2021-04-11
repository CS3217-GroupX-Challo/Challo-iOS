//
//  SearchBarCancelButton.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct SearchBarCancelButton<Presenter: SearchBarPresenter>: View {
    @EnvironmentObject var presenter: Presenter
    @Binding var isEditing: Bool
    
    var body: some View {
        Button(action: {
            self.isEditing = false
            presenter.searchBarText = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }) {
            Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
        .animation(.default)
    }
}
