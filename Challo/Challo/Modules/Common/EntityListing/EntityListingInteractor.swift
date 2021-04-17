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
    
    /// Returns a list of entities cached in memory
    func getCachedEntities() -> [Entity]
}
