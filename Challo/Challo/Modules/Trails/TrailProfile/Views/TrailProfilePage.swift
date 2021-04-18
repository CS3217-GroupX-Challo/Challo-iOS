//
//  TrailProfilePage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfilePage: View {
    @EnvironmentObject var presenter: TrailProfilePresenter
    
    func makeStickyBarContent(_ trail: Trail) -> some View {
        VStack(alignment: .leading) {
            Text("\(trail.lowestFee)").bold() + Text(" Rp / pax")
            StarRatingsView(rating: trail.rating, numOfReviews: trail.numOfReviews, maxHeight: 12)
        }
    }
    
    var ctaButtonContent: some View {
        NavigationLink(destination: presenter.trailBookingPage) {
            Text("Book This Trail")
        }
    }
    
    var body: some View {
        EntityProfilePage<TrailProfilePresenter>(defaultImage: "guides-background",
                                                 detailsContent: { AnyView(TrailProfileDetails()) },
                                                 ctaButtonContent: { AnyView(ctaButtonContent) },
                                                 stickyBarContent: { trail in AnyView(makeStickyBarContent(trail)) })
    }
}
