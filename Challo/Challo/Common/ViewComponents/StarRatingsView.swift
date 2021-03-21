//
//  StarRatingsView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct StarRatingsView: View {
    var rating: Double
    var numOfReviews: Int?
    
    var maxRating: Int = 5
    let onImage = Image(systemName: "star.fill")

    let offColor = Color.gray
    let onColor = Color.yellow
    
    var maxHeight: CGFloat = 15
    
    var body: some View {
        HStack {
            HStack(spacing: 1) {
                ForEach(1..<maxRating + 1) { number in
                    onImage.resizable()
                        .scaledToFit()
                        .frame(maxHeight: maxHeight)
                        .foregroundColor(Double(number) > self.rating ? self.offColor : self.onColor)
                }
            }
            if let unwrappedNumOfReviews = numOfReviews {
                Text("(\(unwrappedNumOfReviews) Reviews)").foregroundColor(.gray)
            }
        }
    }
}
