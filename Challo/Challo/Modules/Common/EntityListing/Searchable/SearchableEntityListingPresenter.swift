//
//  SearchableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

protocol SearchableEntityListingPresenter: ObservableObject {
    associatedtype Entity
    var searchPresenter: EntityListingSearchPresenter<Entity> { get set }
}
