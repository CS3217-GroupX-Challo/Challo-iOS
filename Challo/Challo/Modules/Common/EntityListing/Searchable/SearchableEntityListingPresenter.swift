//
//  SearchableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI
import Combine

/// A presenter which allows for searching of entities
protocol SearchableEntityListingPresenter: ObservableObject {
    associatedtype Entity
    var searchPresenter: EntityListingSearchPresenter<Entity>! { get set }
}
