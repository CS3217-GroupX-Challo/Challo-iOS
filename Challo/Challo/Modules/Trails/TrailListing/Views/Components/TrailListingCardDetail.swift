//
//  TrailListingCardDetail.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingCardDetail: View {
    
    let highlightedTags = ["DISCOUNTED"]
    
    let title: String
    let tags: [String]
    let lowestFeePerPax: Int
    let tourDescription: String
    let rating: Double
    let numOfReviews: Int
    
    @ViewBuilder
    func makeTag(_ index: Int) -> some View {
        Text(tags[index])
            .foregroundColor(highlightedTags.contains(tags[index]) ? .green : .black)
            .bold()
        if index < tags.count - 1 {
            Text("|")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).bold()
            Divider()
            HStack {
                ForEach(tags.indices, id: \.self, content: makeTag)
            }
            StarRatingsView(rating: rating, numOfReviews: numOfReviews)
            Group {
                Text("Guided tours starts at: ") + Text("\(lowestFeePerPax) ").bold() + Text("Rp per pax")
            }
            Text(tourDescription)
        }
    }
}
