//
//  ListingPage.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct ListingPage<Presenter: EntityPresenter>: View {
    
    @EnvironmentObject var presenter: Presenter
    
    let pageTitle: String
    let searchBarSheetContent: AnyView?
    
    var cards: some View {
        ForEach(presenter.displayedCards.indices, id: \.self) { index in
            NavigationLink(destination: presenter.profilePage) {
                presenter.displayedCards[index]
            }.buttonStyle(PlainButtonStyle())
            .simultaneousGesture(TapGesture().onEnded {
                presenter.onTapListingCard(presenter.displayedCards[index].id)
            })
        }
    }
    
    var cardList: some View {
        VStack {
            SearchBar<Presenter>(searchBarSheet: searchBarSheetContent)
            if presenter.isLoading {
                Loading(isAnimating: .constant(true), style: .large)
            }
            RefreshableScrollView(refreshing: $presenter.isRefreshing) {
                VStack(spacing: 30) {
                    cards
                }
            }
        }.padding(.bottom, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var body: some View {
        PageLayout(titleLabel: pageTitle) { _ in
            cardList
        }
    }
}
