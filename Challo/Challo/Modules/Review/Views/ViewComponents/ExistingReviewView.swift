//
//  ExistingReviewView.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

struct ExistingReviewView: View {

    var review: Review

    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Review")
                .font(.title2)
                .foregroundColor(.themeTertiary)

            Divider()

            StarRatingsView(rating: Double(review.rating))
            
            Text(review.comment)
                .lineLimit(nil)
                .font(.body)
                .foregroundColor(.themeForeground)
                .padding(.vertical, 10)

            Label("Posted on \(CustomDateFormatter.displayFriendlyDate(review.createdAt))",
                  systemImage: "clock")
                .font(.subheadline)
                .foregroundColor(.themeForeground)
        }
        .padding()
    }
}
