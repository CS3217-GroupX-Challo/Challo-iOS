//
//  GuideTrailsDetailCard.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideTrailsDetailCard: View {
    var trail: Trail
    var width: CGFloat
    
    var body: some View {
        Card {
            Image(trail.images.first ?? "trails-default-image")
                .resizable()
                .scaledToFill()
                .frame(width: width)
                .padding(5)
            Text(trail.title)
                .font(.title2)
                .bold()
                .lineLimit(nil)
                .frame(width: width)
                .padding(5)
            Text(trail.description)
                .lineLimit(nil)
                .frame(width: width)
                .padding(5)
        }
        .frame(width: width)
    }
}
