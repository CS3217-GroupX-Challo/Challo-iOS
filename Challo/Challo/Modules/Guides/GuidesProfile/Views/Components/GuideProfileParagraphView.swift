//
//  GuideProfileDetailsTitle.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideProfileParagraphView: View {
    var title: String
    var content: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
        Text(content)
            .lineLimit(nil)
    }
}
