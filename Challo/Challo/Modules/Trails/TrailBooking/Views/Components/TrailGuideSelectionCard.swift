//
//  TrailGuideSelectionCard.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import SwiftUI

struct TrailGuideSelectionCard: View {

    var guide: Guide?
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        Card {
            Image(guide?.profileImg ?? "avatar-image")
                .resizable()
                .scaledToFit()
                .frame(width: width * 4 / 5)
                .cornerRadius(10)
                .padding(10)
            Text("hello")
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .bold()
            StarRatingsView(rating: 5)
                .padding(5)
                .frame(maxWidth: width)
        }
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}

struct TrailGuideSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        TrailGuideSelectionCard(guide: nil,
                                width: 500,
                                height: 500)
    }
}
