//
//  TrailProfileDescription.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileDescription: View {
    
    let trail: Trail
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            VStack(alignment: .leading) {
                TrailProfileSectionTitle(title: "Landmarks")
                TrailProfileLandmarks(trail: trail)
            }.frame(maxWidth: 200)
            VStack(alignment: .leading) {
                TrailProfileSectionTitle(title: "About")
                Text(trail.description)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
