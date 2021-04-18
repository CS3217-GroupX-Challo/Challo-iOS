//
//  EntityListingCard.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct EntityListingCard: View {
    let id: String
    
    let entityImage: String?
    let defaultImage: String
    let content: () -> AnyView
    
    var body: some View {
        HStack(spacing: 30) {
            ImageLoader(profileImg: entityImage, defaultImage: defaultImage)
                .frame(maxWidth: 300)
                .cornerRadius(10)
            content()
        }.frame(maxHeight: 200)
    }
}
