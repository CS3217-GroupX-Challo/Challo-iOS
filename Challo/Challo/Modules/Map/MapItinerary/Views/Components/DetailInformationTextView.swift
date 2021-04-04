//
//  DetailInformationTextView.swift
//  Challo
//
//  Created by Kester Ng on 4/4/21.
//

import SwiftUI

struct DetailInformationTextView: View {
    let information: String
    
    var body: some View {
        Text(information)
            .font(.title3)
            .lineLimit(nil)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.themeTertiary, lineWidth: 1)
            )
            .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color.themeQuatenary))
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
    }
}
