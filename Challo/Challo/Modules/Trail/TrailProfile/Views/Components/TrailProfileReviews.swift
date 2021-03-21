//
//  TrailProfileReviews.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileReviews: View {
    @EnvironmentObject var presenter: TrailProfilePresenter

    struct ActivityIndicator: UIViewRepresentable {

        @Binding var isAnimating: Bool
        let style: UIActivityIndicatorView.Style

        func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
            UIActivityIndicatorView(style: style)
        }

        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TrailProfileSectionTitle(title: "Reviews")
            if presenter.isLoadingReviews {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
                    .alignmentGuide(.leading) { d in d[.trailing] }
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(presenter.reviews, id: \.reviewId) { review in
                            TrailProfileReview(review: review)
                        }
                    }
                }
            }
        }
    }
}
