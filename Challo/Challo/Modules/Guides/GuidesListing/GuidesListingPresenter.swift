//
//  GuidesListingPresenter.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import Combine
import Foundation

class GuidesListingPresenter: PresenterProtocol {
    var router: GuidesListingRouter?
    var interactor: GuidesListingInteractor!
    var filterTypes = FilterTypes()
    
    @Published var searchKeyword: String = "" {
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
        if searchKeyword.isEmpty {
            return
        }
        
        guides = guides.filter { guide in
            guide.name?.lowercased().contains(searchKeyword.lowercased())
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
