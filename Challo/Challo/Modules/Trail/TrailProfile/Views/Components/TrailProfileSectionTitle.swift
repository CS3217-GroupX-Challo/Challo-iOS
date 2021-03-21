//
//  TrailProfileSectionTitle.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileSectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title).font(.title2).bold()
            .padding(.bottom, 10)
    }
}
