//
//  GuideLanguagesTagsView.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct GuideLanguagesTagsView: View {
    let width: CGFloat
    let languages: [String]?
    
    var guideLanguages: [String] {
        guard let guideLanguages = languages else {
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
    
    var body: some View {
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
}
