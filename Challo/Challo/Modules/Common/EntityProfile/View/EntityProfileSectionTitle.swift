//
//  EntityProfileSectionTitle.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct EntityProfileSectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title).font(.title2).bold()
            .padding(.bottom, 10)
    }

}
