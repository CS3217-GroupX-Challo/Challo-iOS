//
//  CustomLabelMakers.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

protocol CustomLabelMaker {

    var width: CGFloat { get }
}

extension CustomLabelMaker {
    func makeDetail(image: String, label: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: width / 12)
                .padding(.bottom, 5)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .frame(maxWidth: width / 4, maxHeight: 50)
        }.frame(width: width / 3)
    }
}
