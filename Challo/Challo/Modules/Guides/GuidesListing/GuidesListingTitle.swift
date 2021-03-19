//
//  GuidesListingTitle.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesListingTitle: View {
    var leading: CGFloat
    
    var body: some View {
        Text("Let us guide\nyour way")
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
