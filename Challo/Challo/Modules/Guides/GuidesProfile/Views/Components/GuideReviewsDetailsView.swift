//
//  GuideReviewsDetailsView.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideReviewsDetailsView: View {
    var guide: Guide
    var reviews: [Review]
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Reviews")
                .font(.title3)
                .bold()
                .frame(width: width * 4 / 5, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 30,
                                    bottom: 0, trailing: 0))
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(reviews, id: \.reviewId) { review in
                        GuideReviewCard(review: review,
                                        guide: guide,
                                        width: width)
                            .padding(EdgeInsets(top: 0, leading: 30,
                                                bottom: 0, trailing: 0))
                    }
                }
            }
            Spacer()
        }
    }
}
