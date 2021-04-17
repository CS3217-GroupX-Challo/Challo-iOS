//
//  TrailListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingPresenter: EntityListingPresenter, SearchBarPresenter, ObservableObject {    
    typealias Entity = Trail
    
    var interactor: TrailListingInteractor!
    var router: TrailListingRouter?
    
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            if isRefreshing == true {
                getAllEntities()
            }
        }
    }

    var entities: [Trail] = [] {
        didSet {
            setSlider()
        }
    }
    
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
        var trails = self.entities
        trails = applyFilter(trails)
        trails = applySearchAndSort(trails)
        return trails.map(transformTrailToTrailListingCard)
    }
    
    private func applyFilter(_ trails: [Trail]) -> [Trail] {
        let trails = trails.filter { $0.lowestFee >= priceFilterLowerBound &&
            $0.lowestFee <= priceFilterUpperBound
        }
        return trails.filter { difficultiesToDisplay.contains($0.difficulty) }
    }
    
    private func applySearchAndSort(_ trails: [Trail]) -> [Trail] {
        guard !searchBarText.isEmpty else {
            return trails
        }
        var trails = trails.filter { $0.title.contains(searchBarText) }
        trails.sort {
            $0.title < $1.title
        }
        return trails
    }
    
    private func setSlider() {
        lowestTrailPrice = entities.map { $0.lowestFee }.min() ?? .min
        highestTrailPrice = entities.map { $0.lowestFee }.max() ?? .max
        slider = CustomSlider(width: 600, start: Double(lowestTrailPrice), end: Double(highestTrailPrice))
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
        self.entities = interactor.getCachedEntities()
        getAllEntities()
    }
    
    func getEntityByCardId(_ cardId: String) -> Trail {
        guard let trail = entities.first(where: { $0.trailId == UUID(uuidString: cardId) }) else {
            fatalError("trails is not synced with cards")
        }
        return trail
    }
}
