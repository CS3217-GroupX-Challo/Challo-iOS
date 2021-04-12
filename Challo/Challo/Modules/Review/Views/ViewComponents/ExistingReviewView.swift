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
            Text("You have already written a review for this booking")
                .font(.title)
                .foregroundColor(.themeSecondary)

            Spacer()
        
            Text("Your Review")
                .font(.title2)
                .foregroundColor(.themeTertiary)

            Divider()

            StarRatingsView(rating: Double(review.rating))
            
            Text(review.comment)
                .lineLimit(nil)
                .font(.body)
                .foregroundColor(.themeForeground)

            Label("Posted on \(CustomDateFormatter.displayFriendlyDate(review.createdAt))",
                  systemImage: "clock")
                .font(.subheadline)
                .foregroundColor(.themeForeground)
        }
        .padding()
    }
}
