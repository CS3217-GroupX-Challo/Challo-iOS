//
//  BorderedButtonStyle.swift
//  Challo
//
//  Created by Tan Le Yang on 15/3/21.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
 
    var borderColor: Color
    var foregroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .background(Color.gray.opacity(0))
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(borderColor, lineWidth: 1.5)
            )
    }
}
