//
//  TrailPaxSelection.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailPaxSelection: View {

    @Binding var selectedPax: Int
    @Binding var paxRange: [Int]

    var body: some View {
        Picker("Number of guests: \(selectedPax)", selection: $selectedPax) {
            ForEach(paxRange, id: \.self) {
                Text(String($0))
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
