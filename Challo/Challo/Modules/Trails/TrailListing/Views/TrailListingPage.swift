//
//  TrailListingPage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingPage: View {
    
    @EnvironmentObject var presenter: TrailListingPresenter
    
    var body: some View {
        ListingPage<TrailListingPresenter>(pageTitle: "Find Your Very Own Trail",
                                           searchBarSheetContent: AnyView(TrailListingFilter(presenter: presenter)))
        .onAppear {
            presenter.onPageAppear()
            #warning("TODO: Don't make API requests on every page appear")
        }
    }
}
