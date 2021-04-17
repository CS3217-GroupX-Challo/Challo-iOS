//
//  GuidesListingPresenter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI
import Combine
import Foundation

class GuidesListingPresenter: SearchBarPresenter {
    
    var router: GuidesListingRouter?
    var interactor: GuidesListingInteractor!
    var filterTypes = FilterTypes()
    
    @Published var isSelectedGuideSheetOpen = false
    @Published var selectedGuide: Guide?
    
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            if isRefreshing {
                populateGuides()
            }
        }
    }
    
    @Published var slider = CustomSlider(width: 600, start: 1, end: 5)
    
    @Published var isSearchBarSheetOpen: Bool = false
    @Published var searchBarText: String = "" {
        didSet {
            applyFiltering()
        }
    }
    
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
    
    @Published var guides: [Guide] = []
    var originalGuides: [Guide] = []
    
    var displayedGuides: [Guide] {
        guides.sorted {
            ($0.name ?? "").lowercased() < ($1.name ?? "").lowercased()
        }
    }
    
    func didPopulateGuides(guides: [Guide]) {
        self.guides = guides
        originalGuides = guides
        isLoading = false
        isRefreshing = false
    }
    
    func populateGuides() {
        interactor.populateGuides()
    }

    func onAppear() {
        isLoading = true
        self.guides = interactor.getCachedEntities()
        interactor.populateGuides()
    }
    
    func getGuideProfileDetailsPage(guide: Guide) -> some View {
        router?.getGuideProfileDetailsPage(guide: guide)
    }
}

// MARK: - Filtering logic
extension GuidesListingPresenter {
    private func applyFiltering() {
        guides = originalGuides
        filterBySearchKeyword()
        filterBySex()
        filterByLanguage()
        filterByRating()
    }
    
    private func filterBySearchKeyword() {
        if searchBarText.isEmpty {
            return
        }
        
        guides = guides.filter { guide in
            guide.name?.lowercased().contains(searchBarText.lowercased())
                ?? false
        }
    }
    
    private func filterBySex() {
        guard sexFilterType != "Default" else {
            return
        }
        
        guides = guides.filter { guide in
            guide.sex == Sex(rawValue: sexFilterType)
        }
    }
    
    private func filterByLanguage() {
        guard languageFilterType != "Default" else {
            return
        }
        
        guides = guides.filter { guide in
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
        
        guides = guides.filter { guide in
            guard let ratingToFilter = Double(ratingFilterType) else {
                return false
            }
            
            return guide.rating >= ratingToFilter
        }
    }
}
