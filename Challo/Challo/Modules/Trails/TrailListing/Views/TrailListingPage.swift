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
        VStack {
            SearchBar<TrailListingPresenter>(searchBarSheet: AnyView(TrailListingFilter(presenter: presenter)))
            if presenter.isLoading {
                Loading(isAnimating: .constant(true), style: .large)
            }
            RefreshableScrollView(refreshing: $presenter.isRefreshing) {
                VStack(spacing: 30) {
                    trailCards
                }
            }
        }.padding(.bottom, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Find Your Very Own Trail") { _ in
            cardList
        }.onAppear {
            presenter.onPageAppear()
            #warning("TODO: Don't make API requests on every page appear")
        }
    }
}
