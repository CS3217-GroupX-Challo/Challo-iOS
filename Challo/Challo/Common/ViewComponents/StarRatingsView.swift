//
//  StarRatingsView.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct StarRatingsView: View {
    var rating: Double
    
    var maxRating: Int = 5
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1) { number in
                onImage
                    .foregroundColor(Double(number) > self.rating ? self.offColor : self.onColor)
            }
        }
    }
}
