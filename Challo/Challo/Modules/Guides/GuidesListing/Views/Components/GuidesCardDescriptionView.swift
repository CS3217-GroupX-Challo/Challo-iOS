//
//  GuidesCardDescriptionView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesCardDescriptionView: View {
    var title: String
    var description: String?
    var width: CGFloat
    var content: AnyView?
    
    var body: some View {
        VStack(spacing: 3) {
            Text(title)
                .bold()
                .font(.caption2)
                .frame(height: 5)
            if let cardDescription = description {
                Text(cardDescription)
                    .font(.caption2)
                    .lineLimit(3)
                    .padding(5)
                    .frame(width: width)
            }
            if let unwrappedContent = content {
                unwrappedContent
                    .padding(.top, 10)
            }
        }
    }
}
