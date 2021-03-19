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
        VStack(spacing: 10) {
            Image(trail.images.first ?? "trails-default-image")
                .resizable()
                .scaledToFit()
                .frame(width: width)
            Text(trail.title)
                .font(.title2)
                .bold()
                .lineLimit(nil)
                .frame(width: width)
             
            Text(trail.description)
                .lineLimit(nil)
                .frame(width: width)
        }
    }
}
