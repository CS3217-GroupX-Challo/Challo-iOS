//
//  BlogWriterButton.swift
//  Challo
//
//  Created by Ying Gao on 21/3/21.
//

import SwiftUI

struct BlogWriterButton: View {

    var action: () -> Void
    var title: String

    var body: some View {
        Button(action: action, label: {
            Text(title).bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
    }

}
