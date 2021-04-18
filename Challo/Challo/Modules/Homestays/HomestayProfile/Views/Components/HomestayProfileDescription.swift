//
//  HomestayProfileDescription.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfileDescription: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            EntityProfileSectionTitle(title: "About")
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
