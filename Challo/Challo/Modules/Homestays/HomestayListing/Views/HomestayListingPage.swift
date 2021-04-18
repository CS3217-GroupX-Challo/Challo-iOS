//
//  HomestayListingPage.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayListingPage: View {
    
    @EnvironmentObject var presenter: HomestayListingPresenter

    var body: some View {
        ListingPage<HomestayListingPresenter>(pageTitle: "Find Your Very Own Trail",
                                              searchBarSheetContent: nil)
        .onAppear {
            presenter.onPageAppear()
            #warning("TODO: Don't make API requests on every page appear")
        }
    }
}
