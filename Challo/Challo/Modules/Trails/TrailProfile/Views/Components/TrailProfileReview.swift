//
//  TrailProfileReview.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileReview: View {
    let review: Review
    
    init(review: Review) {
        self.review = review
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ImageLoader(profileImg: review.tourist.profileImg, width: 60, height: 60, defaultImage: "avatar-image")
                    .scaledToFit()
                    .frame(maxHeight: 60)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(review.tourist.name ?? "")
                    Text(CustomDateFormatter.displayDateAsMonthYear(review.createdAt)).foregroundColor(.gray)
                }.font(.system(size: 14))
                Spacer()
                StarRatingsView(rating: Double(review.rating), maxHeight: 10)
            }
            Text(review.comment)
                .font(.system(size: 14))
            Spacer()
        }.padding(20)
        .frame(width: 300, height: 220)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: -5, y: -5)
                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 5, y: 5)
                .shadow(color: Color.gray.opacity(0.3), radius: 5)
        )
        
    }
}
