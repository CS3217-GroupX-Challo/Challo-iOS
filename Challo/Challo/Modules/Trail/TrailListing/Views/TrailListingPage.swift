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
                NavigationLink(destination: presenter.trailProfilePage) {
                    presenter.trailListingCards[index]
                }.buttonStyle(PlainButtonStyle())
                .simultaneousGesture(TapGesture().onEnded {
                    presenter.populateTrailProfilePage(trailIndex: index)
                })
            }
        }.padding(EdgeInsets(top: 50, leading: 60, bottom: 30, trailing: 60))
    }
    
    var body: some View {
        PageLayout(titleLabel: "Find Your Very\nOwn Trail") { _ in
            ScrollView {
                cardList
            }
        }
    }
}
