//
//  EntityListingSearchPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI
import Combine

/// A helper class that encapsulates the functionality of search

/// `getSearchCriteriaFromEntity` is a function that given an entity,
/// returns the search attribute for the search key to be applied on
class EntityListingSearchPresenter<Entity>: ObservableObject {
    @Published var searchBarText: String = ""
    @Published var isSearchBarSheetOpen: Bool = false
    
    let getSearchCriteriaFromEntity: (Entity) -> String
    var cancellables = Set<AnyCancellable>()

    init(presenterWillChange: @escaping (() -> Void),
         getSearchCriteriaFromEntity: @escaping (Entity) -> String) {
        self.getSearchCriteriaFromEntity = getSearchCriteriaFromEntity
        
        self.$isSearchBarSheetOpen.sink(receiveValue: { _ in
            presenterWillChange()
        }).store(in: &cancellables)
        self.$searchBarText.sink(receiveValue: { _ in
            presenterWillChange()
        }).store(in: &cancellables)
    }
    
    func applySearch(_ entities: [Entity]) -> [Entity] {
        guard !searchBarText.isEmpty else {
            return entities
        }
        return entities.filter { getSearchCriteriaFromEntity($0).contains(searchBarText) }
    }
    
}
