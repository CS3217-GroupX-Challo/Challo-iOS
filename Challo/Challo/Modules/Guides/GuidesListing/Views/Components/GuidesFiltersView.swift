//
//  GuidesFiltersView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesFiltersView: View {
    @State private var test: String = ""
    var width: CGFloat
    @ObservedObject var presenter: GuidesListingPresenter
    
    var body: some View {
        HStack(alignment: .top) {
            DropDownMenu(selectedOption: $test,
                         menuItems: presenter.filterTypes.locations,
                         menuTitle: "Location",
                         width: width)
            DropDownMenu(selectedOption: $test,
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
