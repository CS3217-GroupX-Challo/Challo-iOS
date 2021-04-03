//
//  InteractiveMapTopBar.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct InteractiveMapTopBar: View {

    @EnvironmentObject var presenter: MapPresenter

    var body: some View {
        HStack {
            TextField("Search...",
                      text: $presenter.searchQuery,
                      onCommit: {
                        presenter.findPlaces()
                      })
                .textFieldStyle(RoundedTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .zIndex(1)
        }
    }
}
