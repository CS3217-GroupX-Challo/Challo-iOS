//
//  GuideRatingView.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct ExperienceRatingView: View {

    @Binding var rating: Int
    @Binding var comments: String

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Leave a Rating")
                    .font(.title3)
                    .foregroundColor(.themeSecondary)
                    .padding(.bottom, 5)
                StarRatingsPickerView(rating: $rating)
            }
            .padding(.bottom, 5)
            VStack(alignment: .leading) {
                Text("How was your experience?")
                    .font(.title3)
                    .foregroundColor(.themeSecondary)
                TextEditor(text: $comments)
                    .font(.body)
                    .foregroundColor(.themeSecondary)
                    .background(Color.themeBackground)
                    .border(Color.themeSecondary)
                    .frame(minWidth: 400,
                           maxWidth: .infinity,
                           minHeight: 400,
                           maxHeight: 500)
            }
        }
        .padding()
    }
}
