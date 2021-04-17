//
//  TrailListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingPresenter: EntityPresenter, ObservableObject {

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

    private var trails: [Trail] = []
    
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
    
    var displayedCards: [ListingCard] {
        var trails = self.trails
        trails = trails.filter { $0.lowestFee >= priceFilterLowerBound &&
                                    $0.lowestFee <= priceFilterUpperBound  
        }
        trails = trails.filter { difficultiesToDisplay.contains($0.difficulty) }
        guard !searchBarText.isEmpty else {
            return trails.map(transformTrailToTrailListingCard)
        }
        trails = trails.filter { $0.title.contains(searchBarText) }
        trails.sort {
            $0.title < $1.title
        }
        return trails.map(transformTrailToTrailListingCard)
    }
    
    var profilePage: AnyView? {
        router?.trailProfilePage
    }
    
    private func setSlider() {
        lowestTrailPrice = trails.map { $0.lowestFee }.min() ?? .min
        highestTrailPrice = trails.map { $0.lowestFee }.max() ?? .max
        slider = CustomSlider(width: 600, start: Double(lowestTrailPrice), end: Double(highestTrailPrice))
    }
    
    func didGetAllTrails(_ trails: [Trail]) {
        self.trails = trails
        setSlider()
        isLoading = false
        isRefreshing = false
    }
    
    func getAllTrails() {
        interactor.getAllTrails()
    }
    
    func transformTrailToTrailListingCard(_ trail: Trail) -> ListingCard {
        ListingCard(id: trail.trailId.uuidString,
                    entityImage: trail.images.isEmpty ? nil : trail.images[0],
                    defaultImage: "mountains-background") {
           AnyView(TrailListingCardDetail(title: trail.title,
                                          tags: trail.tags,
                                          lowestFeePerPax: trail.lowestFee,
                                          tourDescription: trail.description,
                                          rating: trail.rating,
                                          numOfReviews: trail.numOfReviews,
                                          difficulty: trail.difficulty))
        }
    }
    
    func onPageAppear() {
        isLoading = true
        self.trails = interactor.getCachedEntities()
        getAllTrails()
    }
    
    func onTapListingCard(_ cardId: String) {
        guard let trail = trails.first(where: { $0.trailId == UUID(uuidString: cardId) }) else {
            return
        }
        router?.populateTrailProfilePageFor(trail: trail)
    }
}
