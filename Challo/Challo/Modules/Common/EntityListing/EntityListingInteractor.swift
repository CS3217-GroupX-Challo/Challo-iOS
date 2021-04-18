//
//  EntityListingInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 13/4/21.
//

import Foundation

/// An `Interactor` that can retrieve a list of entities.
protocol EntityListingInteractor: InteractorProtocol where Presenter: EntityListingPresenter,
                                                           Presenter.Entity == Entity {

    associatedtype Entity
    
    var repository: Repository<UUID, Entity> & FetchableRepository { get }
        
    /// Fetches all entities from remote server
    func getAllEntities()
    
    /// Returns a list of entities cached in memory
    func getCachedEntities() -> [Entity]

    /// Fetches all entities for the first time
    func initialFetch()
}

extension EntityListingInteractor {
    
    func initialFetch() {
        repository.initialFetch(didFetch: { [weak self] in
            guard let self = self else {
                return
            }
            let entities = self.getCachedEntities()
            self.presenter.didGetAllEntities(entities)
        })
    }
    
    func getAllEntities() {
        repository.fetchAllAndRefresh(didRefresh: { [weak self] in
            guard let self = self else {
                return
            }
            let entities = self.getCachedEntities()
            self.presenter.didGetAllEntities(entities)
        })
    }

    func getCachedEntities() -> [Entity] {
        repository.getAll()
    }
}
