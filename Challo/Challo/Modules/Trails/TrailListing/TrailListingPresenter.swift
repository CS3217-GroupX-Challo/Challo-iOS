//
//  TrailListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingPresenter: SearchBarPresenter, ObservableObject {

    var interactor: TrailListingInteractor!
    var router: TrailListingRouter?
    
    private var trails: [Trail] = []
    private var trailListingCards: [TrailListingCard] = []

    @Published var isLoading = false
    
    @Published var searchBarText: String = ""
    @Published var isSearchBarSheetOpen: Bool = false
    
    @Published var showEasyTrails = false
    @Published var showModerateTrails = false
    @Published var showDifficultTrails = false
    
    var slider = CustomSlider(width: 600, start: 10, end: 100)
    
    var isFiltered: Bool {
        showEasyTrails || showModerateTrails || showDifficultTrails
    }
    
    var displayedTrailListingCards: [TrailListingCard] {
        guard !searchBarText.isEmpty else {
            return trailListingCards
        }
        return trailListingCards.filter { $0.title.contains(searchBarText) }
    }
    
    var trailProfilePage: AnyView? {
        router?.trailProfilePage
    }
    
    func didGetAllTrails(_ trails: [Trail]) {
        self.trails = trails
        trailListingCards = trails.map(transformTrailToTrailListingCard)
        isLoading = false
    }
    
    func getAllTrails() {
        interactor.getAllTrails()
    }
    
    func transformTrailToTrailListingCard(_ trail: Trail) -> TrailListingCard {
        TrailListingCard(title: trail.title, tags: trail.tags, lowestFeePerPax: trail.lowestFee,
                         tourDescription: trail.description, rating: trail.rating, numOfReviews: trail.numOfReviews,
                         difficulty: trail.difficulty)
    }
    
    func populateTrailProfilePage(trailTitle: String) {
        guard let trail = trails.first(where: { $0.title == trailTitle }) else {
            fatalError("Unsync between trails in view and in presenter")
        }
        router?.populateTrailProfilePageFor(trail: trail)
    }
    
    func onPageAppear() {
        isLoading = true
        getAllTrails()
    }
    
}
