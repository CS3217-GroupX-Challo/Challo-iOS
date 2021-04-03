//
//  DetailTitleView.swift
//  Challo
//
//  Created by Kester Ng on 4/4/21.
//

import SwiftUI

struct DetailTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(.themeSecondary)
    }
}
