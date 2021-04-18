//
//  TrailProfileReviews.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileReviews: View {
    @EnvironmentObject var presenter: TrailProfilePresenter
    
    var body: some View {
        VStack(alignment: .leading) {
            TrailProfileSectionTitle(title: "Reviews")
            if presenter.isLoadingReviews {
                Loading(isAnimating: .constant(true), style: .large)
                    .alignmentGuide(.leading) { d in d[.trailing] }
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(presenter.reviews, id: \.reviewId) { review in
                            TrailProfileReview(review: review)
                                .frame(width: 350, height: 250)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                }
            }
        }
    }
}
