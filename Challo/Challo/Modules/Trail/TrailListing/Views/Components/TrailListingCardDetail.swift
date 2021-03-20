//
//  TrailListingCardDetail.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingCardDetail: View {
    
    let title: String
    let tags: [String]
    let lowestFeePerPax: Int
    let tourDescription: String
    let rating: Double
    let numOfReviews: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).bold()
            Divider()
            HStack {
                ForEach(tags.indices) { index in
                    Text(tags[index])
                    if index < tags.count - 1 {
                        Text("|")
                    }
                }
            }
            StarRatingsView(rating: rating, numOfReviews: numOfReviews)
            Group {
                Text("Guided tours starts at: ") + Text("\(lowestFeePerPax) ").bold() + Text("Rp per pax")
            }
            Text(tourDescription)
        }
    }
}
