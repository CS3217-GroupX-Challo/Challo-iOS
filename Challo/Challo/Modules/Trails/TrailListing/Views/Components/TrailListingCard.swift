//
//  TrailListingCard.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingCard: View, Hashable {
    
    let title: String
    let tags: [String]
    let lowestFeePerPax: Int
    let tourDescription: String
    let rating: Double
    let numOfReviews: Int
    let difficulty: TrailDifficulty
    
    var body: some View {
        HStack(spacing: 30) {
            Image("mountain-background").resizable()
                .frame(maxWidth: 300)
                .cornerRadius(10)
            TrailListingCardDetail(title: title, tags: tags, lowestFeePerPax: lowestFeePerPax,
                                   tourDescription: tourDescription, rating: rating, numOfReviews: numOfReviews,
                                   difficulty: difficulty)
        }.frame(maxHeight: 200)
    }
}
