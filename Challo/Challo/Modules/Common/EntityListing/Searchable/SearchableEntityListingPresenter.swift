//
//  SearchableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI
import Combine

protocol SearchableEntityListingPresenter: ObservableObject {
    associatedtype Entity
    var cancellables: Set<AnyCancellable> { get set }
    var searchPresenter: EntityListingSearchPresenter<Entity> { get set }
}

extension SearchableEntityListingPresenter where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func didInitSearchableEntityListingPresenter() {
        searchPresenter.$isSearchBarSheetOpen.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &cancellables)
        searchPresenter.$searchBarText.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &cancellables)
    }
}
