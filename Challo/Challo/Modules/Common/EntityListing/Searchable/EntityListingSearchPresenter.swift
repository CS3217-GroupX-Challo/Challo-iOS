//
//  EntityListingSearchPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

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
