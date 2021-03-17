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
    
    var body: some View {
        HStack(alignment: .top) {
            DropDownMenu(selectedOption: $test,
                         menuItems: ["Option1", "Option2", "Option3"],
                         menuTitle: "Location",
                         width: width)
            DropDownMenu(selectedOption: $test,
                         menuItems: ["Option1", "Option2", "Option3"],
                         menuTitle: "Popularity",
                         width: width)
            DropDownMenu(selectedOption: $test,
                         menuItems: ["Option1", "Option2", "Option3"],
                         menuTitle: "Language",
                         width: width)
            DropDownMenu(selectedOption: $test,
                         menuItems: ["Option1", "Option2", "Option3"],
                         menuTitle: "Gender",
                         width: width)
        }
    }
}
