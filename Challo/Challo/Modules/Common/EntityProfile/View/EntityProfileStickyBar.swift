//
//  EntityProfileStickyBar.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct EntityProfileStickyBar<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        HStack {
            content()
        }.padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: -5)
        )
    }
}
