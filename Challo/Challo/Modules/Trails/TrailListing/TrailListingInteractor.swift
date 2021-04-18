//
//  TrailListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailListingInteractor: EntityListingInteractor {

    typealias Entity = Trail
    
    var repository: TrailRepositoryProtocol
    weak var presenter: TrailListingPresenter!

    init(trailRepository: TrailRepositoryProtocol) {
        self.repository = trailRepository
    }

    func getAllEntities() {
        repository.fetchTrailsAndRefresh(didRefresh: presenter.didGetAllEntities)
    }

    func getCachedEntities() -> [Trail] {
        repository.getAll()
    }

    func initialFetch() {
        repository.initialFetch(didFetch: presenter.didGetAllEntities)
    }
}
