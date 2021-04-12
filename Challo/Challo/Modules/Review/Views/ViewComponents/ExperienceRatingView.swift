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
        VStack {
            HStack(alignment: .top) {
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
                               maxWidth: 700,
                               minHeight: 400,
                               maxHeight: 500)
                }
                
                Spacer()
    
                VStack(alignment: .leading) {
                    Text("Leave a Rating")
                        .font(.title3)
                        .foregroundColor(.themeSecondary)
                        .padding(.bottom, 10)
                    StarRatingsPickerView(rating: $rating)
                }
            }
        }
        .padding()
    }
}
