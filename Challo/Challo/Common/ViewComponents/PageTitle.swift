//
//  PageTitle.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct PageTitle: View {
    
    let titleLabel: String
    let leading: CGFloat
    
    var body: some View {
        Text(titleLabel)
            .foregroundColor(.white)
            .font(.largeTitle)
            .bold()
            .lineLimit(nil)
            .padding(.init(top: 0,
                           leading: leading,
                           bottom: 0,
                           trailing: 0))
    }
}
