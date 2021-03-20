//
//  TrailProfileBasicInfo.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileBasicInfo: View {
    let trail: Trail
    
    var body: some View {
        Text(trail.title).font(.title)
            .bold()
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
        HStack {
            StarRatingsView(rating: trail.rating, numOfReviews: trail.numOfReviews)
            Text("\(trail.area.village), \(trail.area.state)")
            Spacer()
        }
    }
}
