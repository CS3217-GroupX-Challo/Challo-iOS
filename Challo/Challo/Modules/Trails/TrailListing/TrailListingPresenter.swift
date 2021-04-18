//
//  TrailListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI
import Combine

class TrailListingPresenter: EntityListingPresenter,
                             PriceFilterableEntityListingPresenter,
                             SearchableEntityListingPresenter,
                             ObservableObject {
    typealias Entity = Trail
    
    var interactor: TrailListingInteractor!
    var router: TrailListingRouter?
    
    var isFirstLoad = true
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
            priceFilterPresenter.setSlider(entities: entities)
        }
    }
    
    @Published var showEasyTrails = true
    @Published var showModerateTrails = true
    @Published var showDifficultTrails = true
    
    var priceFilterPresenter = EntityListingPriceFilterPresenter<Trail>(getPriceFromEntity: { $0.lowestFee })
    @Published var searchPresenter = EntityListingSearchPresenter<Trail>(getSearchCriteriaFromEntity: { $0.title })
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        didInitSearchableEntityListingPresenter()
    }
    
    var difficultiesToDisplay: [TrailDifficulty] {
        var difficulties = [TrailDifficulty]()
        if showEasyTrails { difficulties.append(.Easy) }
        if showModerateTrails { difficulties.append(.Moderate) }
        if showDifficultTrails { difficulties.append(.Difficult) }
        return difficulties
    }
    
    var displayedCards: [ListingCard] {
        var trails = self.entities
        trails = applyFilter(trails)
        trails = searchPresenter.applySearch(trails)
        trails.sort {
            $0.title < $1.title
        }
        return trails.map(transformTrailToTrailListingCard)
    }
    
    private func applyFilter(_ trails: [Trail]) -> [Trail] {
        let trails = priceFilterPresenter.applyFilter(trails)
        return trails.filter { difficultiesToDisplay.contains($0.difficulty) }
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
    
    func getEntityByCardId(_ cardId: String) -> Trail {
        guard let trail = entities.first(where: { $0.trailId == UUID(uuidString: cardId) }) else {
            fatalError("trails is not synced with cards")
        }
        return trail
    }
}
