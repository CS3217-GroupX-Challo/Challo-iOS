//
//  GuideDetailsCard.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuideDetailsCard: View {
    var guide: Guide
    var width: CGFloat
    
    var presenter: GuidesListingPresenter
    
    var nameDescription: String? {
        guide.name
    }
    
    var imageWidth: CGFloat {
        width * 0.6
    }
    
    var body: some View {
        Card {
            ImageLoader(profileImg: guide.profileImg, width: imageWidth,
                        height: imageWidth, defaultImage: "avatar-image")
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: imageWidth, height: imageWidth)
                .padding(10)
            if let name = nameDescription {
                Text(name)
                    .bold()
                    .font(.subheadline)
                    .padding(5)
            }
            StarRatingsView(rating: guide.rating, maxHeight: 10)
                .padding(5)
                .frame(maxWidth: width)
            GuidesCardDescriptionView(title: "About",
                                      description: guide.biography,
                                      width: width)
                .frame(height: 80)
            GuidesCardDescriptionView(title: "Languages",
                                      width: width,
                                      content: AnyView(GuideLanguagesTagsView(width: width,
                                                                              languages: guide.languages)))

            Image(systemName: "ellipsis")
                .padding()
                .frame(width: 100, height: 30)
                .contentShape(Rectangle())
                .onTapGesture {
                    presenter.isSelectedGuideSheetOpen = true
                    presenter.selectedGuide = guide
                }
        }.background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.gray, lineWidth: 0.5)
                .background(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 3, y: 3)
        )
    }
}
