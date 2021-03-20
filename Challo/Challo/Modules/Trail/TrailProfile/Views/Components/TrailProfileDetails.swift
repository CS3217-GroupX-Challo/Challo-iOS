//
//  TrailProfileDetails.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileDetails: View {
    
    let trail: Trail
    
    var standardEdgeInset: EdgeInsets {
        EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
    }
    
    var divider: some View {
        Divider().padding(standardEdgeInset)
    }
    
    let landmarks = ["Padampuri Village", "Local Village Shrine", "Padampuri Park", "Side of Padampuri Stream", "Padampuri Village"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trail.title).font(.title)
                .bold()
                .padding(standardEdgeInset)
            HStack {
                StarRatingsView(rating: trail.rating, numOfReviews: 389)
                Text("\(trail.area.village), \(trail.area.state)")
                Spacer()
            }
            divider
            TrailProfileSectionTitle(title: "About")
            Text(trail.description)
            divider
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    TrailProfileSectionTitle(title: "Landmarks")
                    TrailProfileLandmarks(landmarks: landmarks)
                }
                VStack(alignment: .leading) {
                    TrailProfileSectionTitle(title: "Location")

                }
            }
        }
    }
}
