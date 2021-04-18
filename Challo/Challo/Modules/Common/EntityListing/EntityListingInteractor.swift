//
//  EntityListingInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 13/4/21.
//

import Foundation

/// An `Interactor` that can retrieve a list of entities.
protocol EntityListingInteractor: InteractorProtocol {

    associatedtype Entity
    
    /// Fetches all entities from remote server
    func getAllEntities()
    
    /// Returns a list of entities cached in memory
    func getCachedEntities() -> [Entity]

    /// Fetches all entities for the first time
    func initialFetch()
}
