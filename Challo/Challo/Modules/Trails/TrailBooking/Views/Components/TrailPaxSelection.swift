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

    var pickerLabel: some View {
        Text("Select Number of Guests: \(selectedPax)")
            .font(.title2)
            .foregroundColor(.themeTertiary)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedPax,
                   label: pickerLabel) {
                ForEach(paxRange, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}
