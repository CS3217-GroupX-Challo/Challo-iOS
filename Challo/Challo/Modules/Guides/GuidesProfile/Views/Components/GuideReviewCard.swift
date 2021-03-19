//
//  GuideReviewCard.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideReviewCard: View {
    var review: Review
    var guide: Guide
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 15) {
                Image(review.tourist.profileImg ?? "avatar-image")
                    .resizable()
                    .frame(width: width / 15,
                           height: width / 15,
                           alignment: .center)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 5) {
                    Text(review.tourist.name ?? "Anonymous")
                        .italic()
                    Text(review.createdAt.description)
                        .italic()
                }
                StarRatingsView(rating: Double(review.rating))
            }
            Text(review.comment)
                .lineLimit(nil)
                .frame(width: width * 4 / 5, alignment: .leading)
        }
    }
}
