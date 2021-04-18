//
//  GuideTrailsListing.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct GuideTrailsListing: View {
    let trails: [Trail]

    let trailImageWidth: CGFloat = 200

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(trails, id: \.trailId) { trail in
                    VStack(alignment: .leading) {
                        ImageLoader(profileImg: trail.images[0],
                                    width: trailImageWidth, height: trailImageWidth,
                                    defaultImage: "mountain-background")
                            .frame(width: trailImageWidth, height: trailImageWidth)
                            .cornerRadius(10)
                        Text(trail.title)
                        StarRatingsView(rating: trail.rating, maxHeight: 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.frame(width: trailImageWidth + 30)
                }
            }
        }
    }
}
