//
//  GuidesListingPresenter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI
import Combine
import Foundation

final class GuidesListingPresenter: LoadableEntityPresenter,
                                    EntityListingPresenter,
                                    SearchableEntityListingPresenter {
    
    typealias Entity = Guide
    
    var router: GuidesListingRouter?
    var interactor: GuidesListingInteractor!
    var filterTypes = FilterTypes()
    
    @Published var isSelectedGuideSheetOpen = false
    @Published var selectedGuide: Guide?
    
    override func onRefresh() {
        populateGuides()
    }
    
    @Published var slider = CustomSlider(width: 600, start: 1, end: 5)
    
    @Published var searchPresenter: EntityListingSearchPresenter<Guide>!
    
    @Published var sexFilterType: String = "Default" {
        didSet {
            applyFiltering()
        }
    }
    
    @Published var languageFilterType: String = "Default" {
        didSet {
            applyFiltering()
        }
    }
    
    @Published var ratingFilterType: String = "Default" {
        didSet {
            applyFiltering()
        }
    }
    
    override init() {
        super.init()
        searchPresenter = EntityListingSearchPresenter<Guide>(
            presenterWillChange: {
                [weak self] in self?.objectWillChange.send()
            }) {
                $0.name ?? ""
        }
    }
    
    @Published var entities: [Guide] = []
    var originalGuides: [Guide] = []
    
    var displayedGuides: [Guide] {
        var guidesToDisplay = entities
        guidesToDisplay = searchPresenter.applySearch(guidesToDisplay)
        return guidesToDisplay.sorted {
            ($0.name ?? "").lowercased() < ($1.name ?? "").lowercased()
        }
    }
    
    var displayedCards: [EntityListingCard] = []
    
    func matchEntityToCardId(entity: Guide, cardId: String) -> Bool {
        entity.userId == UUID(uuidString: cardId)
    }
    
    func didGetAllEntities(entities: [Guide]) {
        self.entities = entities
        originalGuides = entities
        isLoading = false
        isRefreshing = false
    }
    
    func populateGuides() {
        interactor.getAllEntities()
    }

    func onAppear() {
        isLoading = true
        interactor.initialFetch()
    }
    
    func getGuideProfileDetailsPage(guide: Guide) -> some View {
        router?.getGuideProfileDetailsPage(guide: guide)
    }
}

// MARK: - Filtering logic
extension GuidesListingPresenter {
    private func applyFiltering() {
        entities = originalGuides
        filterBySex()
        filterByLanguage()
        filterByRating()
    }
    
    private func filterBySex() {
        guard sexFilterType != "Default" else {
            return
        }
        
        entities = entities.filter { guide in
            guide.sex == Sex(rawValue: sexFilterType)
        }
    }
    
    private func filterByLanguage() {
        guard languageFilterType != "Default" else {
            return
        }
        
        entities = entities.filter { guide in
            guard let languages = guide.languages else {
                return false
            }
            
            return languages.contains { language in
                language.contains(languageFilterType)
            }
        }
    }
    
    private func filterByRating() {
        guard ratingFilterType != "Default" else {
            return
        }
        
        entities = entities.filter { guide in
            guard let ratingToFilter = Double(ratingFilterType) else {
                return false
            }
            
            return guide.rating >= ratingToFilter
        }
    }
}
