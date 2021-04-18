//
//  TrailProfileDetails.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI
import MapKit

struct TrailProfileDetails: View {
    
    @EnvironmentObject var presenter: TrailProfilePresenter
    
    var body: some View {
        UnwrapView(presenter.currentEntity) { trail in
            VStack(alignment: .leading) {
                TrailProfileBasicInfo(trail: trail)
                EntityProfileDivider()
                TrailProfileDescription(trail: trail)
                EntityProfileDivider()
                TrailProfileLocation(trail: trail)
                EntityProfileDivider()
                TrailProfileReviews()
            }
        }
    }
}
