//
//  TabSelectionView.swift
//  Challo
//
//  Created by Tan Le Yang on 10/4/21.
//

import SwiftUI

struct TabSelectionView: View {

    @Binding var selectedIndex: Int
    let options: [String]

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(0..<options.count) { idx in
                TabSelectionOption(title: options[idx],
                                   isSelected: idx == selectedIndex) {
                    selectedIndex = idx
                }
                Spacer()
            }
        }
    }
}
