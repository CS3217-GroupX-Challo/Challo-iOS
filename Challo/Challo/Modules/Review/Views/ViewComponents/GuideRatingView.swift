//
//  GuideRatingView.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct GuideRatingView: View {

    @State private var rating: Int = 0
    @State private var comments: String = ""

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Your Experience")
                        .font(.title3)
                        .foregroundColor(.themeSecondary)
                    TextEditor(text: $comments)
                        .font(.body)
                        .foregroundColor(.themeSecondary)
                        .background(Color.themeBackground)
                        .border(Color.themeSecondary)
                        .frame(minWidth: 0,
                               maxWidth: 700,
                               minHeight: 0,
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

struct GuideRatingView_Previews: PreviewProvider {
    static var previews: some View {
        GuideRatingView()
    }
}
