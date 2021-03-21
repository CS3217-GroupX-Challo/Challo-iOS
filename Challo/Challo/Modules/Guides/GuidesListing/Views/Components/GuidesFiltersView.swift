//
//  GuidesFiltersView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesFiltersView: View {
    var width: CGFloat

    @State private var test: String = ""
    @ObservedObject var presenter: GuidesListingPresenter
    
    var body: some View {
        HStack(alignment: .top) {
            DropDownMenu(selectedOption: $presenter.ratingFilterType,
                         menuItems: presenter.filterTypes.popularityTypes,
                         menuTitle: "Popularity",
                         width: width)
            DropDownMenu(selectedOption: $presenter.languageFilterType,
                         menuItems: presenter.filterTypes.languageTypes,
                         menuTitle: "Language",
                         width: width)
            DropDownMenu(selectedOption: $presenter.sexFilterType,
                         menuItems: presenter.filterTypes.sexTypes,
                         menuTitle: "Gender",
                         width: width)
        }
    }
}
