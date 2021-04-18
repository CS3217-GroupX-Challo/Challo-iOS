//
//  SearchBarRightButton.swift
//  Challo
//
//  Created by Shao Yi on 12/4/21.
//

import SwiftUI

struct SearchBarRightButton<Presenter: SearchableEntityListingPresenter>: View {
    @EnvironmentObject var presenter: Presenter
    @Binding var isEditing: Bool
    
    let isFilterable: Bool

    func buttonAction() {
        if isEditing {
            presenter.searchPresenter.searchBarText = ""
        } else if isFilterable {
            presenter.searchPresenter.isSearchBarSheetOpen = true
        }
    }
    
    var body: some View {
        if !isEditing && !isFilterable {
            EmptyView()
        } else {
            Button(action: buttonAction) {
                Image(systemName: isEditing
                        ? "multiply.circle.fill"
                        : "slider.horizontal.3")
                    .font(Font.headline.weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.trailing, 8)
            }
        }
    }
}
