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
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                Text("About")
                    .foregroundColor(Color.themeTertiary)
                    .font(.largeTitle)
                    .bold()
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Bio")
                            .font(.title3)
                            .bold()
                        Text(guide.biography ?? "No description")
                            .lineLimit(nil)
                        Spacer()
                    }
                    .frame(width: width * 4 / 10)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("My hobbies are...")
                            .font(.title3)
                            .bold()
                        Text(guide.hobbies ?? "No hobbies listed")
                            .lineLimit(nil)
                        Text("My most memorable experiences are...")
                            .font(.title3)
                            .bold()
                        Text(guide.memorableExperiences ?? "No experiences listed")
                            .lineLimit(nil)
                        Spacer()
                    }
                    .frame(width: width * 4 / 10)
                }
                Spacer()
            }
            .frame(width: width)
        }
    }
}
