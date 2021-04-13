//
//  EntityListingInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 13/4/21.
//

/// An `Interactor` that can retrieve a list of entities from a `Repository`
protocol EntityListingInteractor: InteractorProtocol {

    associatedtype Repo: RepositoryProtocol

    var repository: Repo { get }

    /// Retrieve the entities currently cached in the repository
    func getCachedEntities() -> [Repo.Entity]
}

extension EntityListingInteractor {

    func getCachedEntities() -> [Repo.Entity] {
        repository.getAll()
    }
}
