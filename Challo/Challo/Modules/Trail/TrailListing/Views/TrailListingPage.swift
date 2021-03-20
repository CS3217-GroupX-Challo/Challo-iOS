//
//  TrailListingPage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingPage: View {
    
    @EnvironmentObject var presenter: TrailListingPresenter
    
    var cardList: some View {
        VStack(spacing: 30) {
            ForEach(presenter.trailListingCards.indices) { index in
                NavigationLink(destination: presenter.trailProfilePage.onAppear {
                    presenter.populateTrailProfilePage(trailIndex: index)
                }) {
                    presenter.trailListingCards[index]
                }.buttonStyle(PlainButtonStyle())
            }
        }.padding(EdgeInsets(top: 30, leading: 60, bottom: 30, trailing: 60))
    }
    
    var body: some View {
        PageLayout(titleLabel: "Find Your Very\nOwn Trail") {
            cardList
        }
    }
}
