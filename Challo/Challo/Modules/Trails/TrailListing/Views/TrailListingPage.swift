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
        Group {
            RefreshableScrollView(refreshing: $presenter.isRefreshing) {
                if presenter.isLoading {
                    VStack(alignment: .trailing) {
                        Loading(isAnimating: .constant(true), style: .large)
                    }
                }
                VStack(spacing: 30) {
                    ForEach(presenter.trailListingCards.indices, id: \.self) { index in
                        NavigationLink(destination: presenter.trailProfilePage) {
                            presenter.trailListingCards[index]
                        }.buttonStyle(PlainButtonStyle())
                        .simultaneousGesture(TapGesture().onEnded {
                            presenter.populateTrailProfilePage(trailIndex: index)
                        })
                    }
                }.padding(EdgeInsets(top: 50, leading: 60, bottom: 30, trailing: 60))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        PageLayout(titleLabel: "Find Your Very\nOwn Trail") { _ in
            cardList
        }.onAppear {
            presenter.onPageAppear()
        }
    }
}
