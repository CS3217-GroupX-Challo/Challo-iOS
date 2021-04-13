//
//  StarRatingsInteractiveView.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct StarRatingsPickerView: View {

    @Binding var rating: Int

    var maxRating: Int = 5

    private let onImage = Image(systemName: "star.fill")
    private let offImage = Image(systemName: "star")

    private let onColor = Color.yellow
    private let offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1) { num in
                image(for: num)
                    .foregroundColor(num > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = num
                    }
            }
        }
    }

    func image(for number: Int) -> Image {
        number > rating ? offImage : onImage
    }
}
