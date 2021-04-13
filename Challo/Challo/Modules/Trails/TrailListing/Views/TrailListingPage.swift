//
//  TrailListingPage.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailListingPage: View {
    
    @EnvironmentObject var presenter: TrailListingPresenter
    
    var trailCards: some View {
        ForEach(presenter.displayedTrailListingCards.indices, id: \.self) { index in
            NavigationLink(destination: presenter.trailProfilePage) {
                presenter.displayedTrailListingCards[index]
            }.buttonStyle(PlainButtonStyle())
            .simultaneousGesture(TapGesture().onEnded {
                presenter.populateTrailProfilePage(trailTitle: presenter.displayedTrailListingCards[index].title)
            })
        }
    }
    
    var cardList: some View {
        Group {
            VStack {
                SearchBar<TrailListingPresenter>(searchBarSheet: AnyView(TrailListingFilter(presenter: presenter)))
                    .padding(.bottom, 40)
                RefreshableScrollView(refreshing: $presenter.isRefreshing) {
                    VStack(spacing: 30) {
                        trailCards
                    }
                }
            }.padding(EdgeInsets(top: 50, leading: 60, bottom: 30, trailing: 60))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Find Your Very Own Trail") { _ in
            cardList
        }.onAppear {
            presenter.onPageAppear()
        }
    }
}
