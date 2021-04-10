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

    var baseView: some View {
        Text(title)
    }

    var body: some View {
        if isSelected {
            baseView
                .foregroundColor(.themeTertiary)
        } else {
            baseView
                .foregroundColor(.themeForeground)
                .opacity(0.6)
        }
    }
}
