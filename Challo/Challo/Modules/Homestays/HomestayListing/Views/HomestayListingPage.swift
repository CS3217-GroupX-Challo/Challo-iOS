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
        ListingPage<HomestayListingPresenter>(pageTitle: "Find Your Home in Nature",
                                              searchBarSheetContent: AnyView(HomestayFilterView()
                                                                                .environmentObject(presenter)))
        .onAppear {
            presenter.onPageAppear()
        }
    }
}
