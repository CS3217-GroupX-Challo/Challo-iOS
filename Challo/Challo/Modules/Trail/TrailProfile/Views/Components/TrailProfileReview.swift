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
                Image("avatar-image")
                    .resizable()
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
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1.5))
        
    }
}
