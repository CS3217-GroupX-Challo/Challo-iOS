//
//  EntityListingSearchPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

/// A helper class that encapsulates the functionality of search
/// `getSearchCriteriaFromEntity` is a function that given an entity, returns the search attribute
/// for the search key to be applied on
class EntityListingSearchPresenter<Entity>: ObservableObject {
    @Published var searchBarText: String = ""
    @Published var isSearchBarSheetOpen: Bool = false
    
    let getSearchCriteriaFromEntity: (Entity) -> String
    
    init(getSearchCriteriaFromEntity: @escaping (Entity) -> String) {
        self.getSearchCriteriaFromEntity = getSearchCriteriaFromEntity
    }
    
    func applySearch(_ entities: [Entity]) -> [Entity] {
        guard !searchBarText.isEmpty else {
            return entities
        }
        return entities.filter { getSearchCriteriaFromEntity($0).contains(searchBarText) }
    }
    
}
