//
//  GuideAboutDetailsView.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import SwiftUI

struct GuideAboutDetailsView: View {
    var guide: Guide
    var width: CGFloat
    var height: CGFloat
    
    var trail: Trail {
        guide.trails.first!
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                Text("About")
                    .foregroundColor(Color.themeTertiary)
                    .font(.largeTitle)
                    .bold()
                HStack(alignment: .top, spacing: 30) {
                    VStack(alignment: .leading, spacing: 15) {
                        GuideProfileParagraphView(title: "Bio",
                                                  content: guide.biography ?? "No description")
                    }
                    .frame(width: width * 4 / 10)
                    VStack(alignment: .leading, spacing: 15) {
                        GuideProfileParagraphView(title: "My hobbies are...",
                                                  content: guide.hobbies ?? "No hobbies listed")
                        GuideProfileParagraphView(title: "My most memorable experiences are...",
                                                  content: guide.memorableExperiences ?? "No experiences listed")
                    }
                    .frame(width: width * 4 / 10)
                }
                VStack(spacing: 15) {
                    Text("Trails")
                        .font(.title3)
                        .bold()
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 15) {
                            ForEach(guide.trails, id: \.trailId) { trail in
                                 GuideTrailsDetailCard(trail: trail,
                                                       width: width / 3)
                            }
                        }
                    }
                }
            }
        }
    }
}
