//
//  TabSelectionOption.swift
//  Challo
//
//  Created by Tan Le Yang on 10/4/21.
//

import SwiftUI

struct TabSelectionOption: View {

    var title: String
    var isSelected: Bool
    var onSelect: (() -> Void)?

    private let selectedColor = Color.themeTertiary
    private let unselectedColor = Color.themeForeground

    var baseView: some View {
        Text(title)
            .font(.title2)
            .bold()
            .onTapGesture {
                if let onSelect = onSelect {
                    onSelect()
                }
            }
    }

    var body: some View {
        if isSelected {
            baseView
                .foregroundColor(selectedColor)
        } else {
            baseView
                .foregroundColor(unselectedColor)
                .opacity(0.6)
        }
    }
}
