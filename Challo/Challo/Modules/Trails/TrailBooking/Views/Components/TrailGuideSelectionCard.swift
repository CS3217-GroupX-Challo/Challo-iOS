//
//  TrailGuideSelectionCard.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import SwiftUI

struct TrailGuideSelectionCard: View {

    var guide: Guide
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        Card {
            Image(guide.profileImg ?? "avatar-image")
                .resizable()
                .scaledToFit()
                .frame(width: width * 4 / 5)
                .cornerRadius(10)
                .padding(10)
            Text(guide.name ?? "Challo Naveen")
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .bold()
            StarRatingsView(rating: guide.rating)
                .padding(5)
                .frame(maxWidth: width)
        }
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}
