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
    
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            if isRefreshing == true {
                getAllTrails()
            }
        }
    }

    var trails: [Trail] = []
    private var trailListingCards: [TrailListingCard] = []
    
    @Published var searchBarText: String = ""
    @Published var isSearchBarSheetOpen: Bool = false
    
    @Published var showEasyTrails = true
    @Published var showModerateTrails = true
    @Published var showDifficultTrails = true
    
    var difficultiesToDisplay: [TrailDifficulty] {
        var difficulties = [TrailDifficulty]()
        if showEasyTrails { difficulties.append(.Easy) }
        if showModerateTrails { difficulties.append(.Moderate) }
        if showDifficultTrails { difficulties.append(.Difficult) }
        return difficulties
    }
    
    @Published var slider = CustomSlider(width: 600, start: 0, end: 0)
    
    var lowestTrailPrice: Int = .min
    var highestTrailPrice: Int = .max
    
    var priceFilterLowerBound: Int {
        Int(floor(slider.lowHandle.currentValue))
    }
    
    var priceFilterUpperBound: Int {
        Int(ceil(slider.highHandle.currentValue))
    }
    
    var displayedTrailListingCards: [TrailListingCard] {
        var displayedCards = trailListingCards
        displayedCards = displayedCards.filter { $0.lowestFeePerPax >= priceFilterLowerBound &&
                                                    $0.lowestFeePerPax <= priceFilterUpperBound  
        }
        displayedCards = displayedCards.filter { difficultiesToDisplay.contains($0.difficulty) }
        guard !searchBarText.isEmpty else {
            return displayedCards
        }
        displayedCards = displayedCards.filter { $0.title.contains(searchBarText) }
        return displayedCards
    }
    
    var trailProfilePage: AnyView? {
        router?.trailProfilePage
    }
    
    private func setSlider() {
        lowestTrailPrice = trails.map { $0.lowestFee }.min() ?? .min
        highestTrailPrice = trails.map { $0.lowestFee }.max() ?? .max
        slider = CustomSlider(width: 600, start: Double(lowestTrailPrice), end: Double(highestTrailPrice))
    }
    
    func didGetAllTrails(_ trails: [Trail]) {
        self.trails = trails
        trailListingCards = trails.map(transformTrailToTrailListingCard)
        setSlider()
        isLoading = false
        isRefreshing = false
    }
    
    func getAllTrails() {
        interactor.getAllTrails()
    }
    
    func transformTrailToTrailListingCard(_ trail: Trail) -> TrailListingCard {
        TrailListingCard(title: trail.title, tags: trail.tags, lowestFeePerPax: trail.lowestFee,
                         tourDescription: trail.description, rating: trail.rating, numOfReviews: trail.numOfReviews,
                         difficulty: trail.difficulty, images: trail.images)
    }
    
    func populateTrailProfilePage(trailTitle: String) {
        guard let trail = trails.first(where: { $0.title == trailTitle }) else {
            fatalError("Unsync between trails in view and in presenter")
        }
        router?.populateTrailProfilePageFor(trail: trail)
    }
    
    func onPageAppear() {
        isLoading = true
        self.trails = interactor.getCachedEntities()
        getAllTrails()
    }
}
