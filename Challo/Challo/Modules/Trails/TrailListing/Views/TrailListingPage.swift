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
        ProfilableEntityListingPage<TrailListingPresenter>(pageTitle: "Find Your Very Own Trail",
                                           searchBarSheetContent: AnyView(TrailListingFilter()
                                                                            .environmentObject(presenter)))
        .onAppear {
            presenter.onPageAppear()
        }
    }
}
