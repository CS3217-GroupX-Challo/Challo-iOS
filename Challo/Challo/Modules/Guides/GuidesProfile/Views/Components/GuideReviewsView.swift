//
//  GuideReviewsView.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct GuideReviewsView: View {
    let reviews: [Review]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(reviews, id: \.reviewId) { review in
                    TrailProfileReview(review: review)
                        .frame(width: 350, height: 250)
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        }
    }
}
