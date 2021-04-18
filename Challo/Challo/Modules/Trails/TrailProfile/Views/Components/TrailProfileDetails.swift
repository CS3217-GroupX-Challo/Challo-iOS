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

    var standardEdgeInset: EdgeInsets {
        EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
    }
    
    var divider: some View {
        Divider().padding(standardEdgeInset)
    }
    
    var body: some View {
        UnwrapView(presenter.currentEntity) { trail in
            VStack(alignment: .leading) {
                TrailProfileBasicInfo(trail: trail)
                divider
                TrailProfileDescription(trail: trail)
                divider
                TrailProfileLocation(trail: trail)
                divider
                TrailProfileReviews()
            }
        }
    }
}
