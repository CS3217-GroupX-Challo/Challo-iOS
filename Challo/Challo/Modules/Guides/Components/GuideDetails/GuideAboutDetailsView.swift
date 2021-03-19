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
    
    var trail = Trail(trailId: UUID(), title: "Nandadevi Village", description: "Guided tours available from 1500 ₹",
                      positions: [], distance: Decimal.zero, duration: Decimal.zero,
                      elevation: Decimal.zero, images: [],
                      area: Area(areaId: UUID(), areaName: "test", regionName: "test"))
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                Text("About")
                    .foregroundColor(Color.themeTertiary)
                    .font(.largeTitle)
                    .bold()
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        GuideProfileParagraphView(title: "Bio",
                                                  content: guide.biography ?? "No description")
                        Spacer()
                    }
                    .frame(width: width * 4 / 10)
                    VStack(alignment: .leading, spacing: 15) {
                        GuideProfileParagraphView(title: "My hobbies are...",
                                                  content: guide.hobbies ?? "No hobbies listed")
                        GuideProfileParagraphView(title: "My most memorable experiences are...",
                                                  content: guide.memorableExperiences ?? "No experiences listed")
                        Spacer()
                    }
                    .frame(width: width * 4 / 10)
                }
                VStack(spacing: 15) {
                    Text("Trails")
                        .font(.title3)
                        .bold()
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            GuideTrailsDetailCard(trail: trail,
                                                  width: width / 3)
                            GuideTrailsDetailCard(trail: trail,
                                                  width: width / 3)
                            GuideTrailsDetailCard(trail: trail,
                                                  width: width / 3)
                            GuideTrailsDetailCard(trail: trail,
                                                  width: width / 3)
                        }
                    }
                }
            }
            .frame(width: width)
        }
    }
}
