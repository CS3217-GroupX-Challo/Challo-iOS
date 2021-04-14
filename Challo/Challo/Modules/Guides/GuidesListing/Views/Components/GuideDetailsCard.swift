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
    
    var languagesDescription: String? {
        convertStringArrayToString(strings: guide.languages)
    }
    
    var imageWidth: CGFloat {
        width * 0.6
    }
    
    var guideLanguages: [String] {
        guard let guideLanguages = guide.languages else {
            return []
        }
        let splitLanguages = guideLanguages.map { $0.components(separatedBy: "/") }
        return splitLanguages.flatMap { $0 }
    }
    
    func makeLanguageTag(_ language: String) -> some View {
        Text(language)
            .font(.caption2)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.themeTertiary)
            )
    }
    
    var languages: AnyView {
        AnyView(
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                    ForEach(guideLanguages.dropLast(guideLanguages.count % 3), id: \.self) { language in
                        makeLanguageTag(language)
                    }
                }
                LazyHStack {
                    ForEach(guideLanguages.suffix(guideLanguages.count % 3), id: \.self) { language in
                        makeLanguageTag(language)
                    }
                }
            }.frame(maxWidth: width * 0.9)
        )
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
                                      content: languages)

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
    
    private func convertStringArrayToString(strings: [String]?) -> String? {
        guard let stringArray = strings else {
            return nil
        }
        
        var result = ""
        for i in 0..<stringArray.count {
            result += stringArray[i]
            if i != stringArray.count - 1 {
                result += ", "
            }
        }
        return result
    }
}
