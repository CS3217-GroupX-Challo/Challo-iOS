//
//  TrailListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailListingInteractor: InteractorProtocol {

    var repository: TrailRepositoryProtocol
    weak var presenter: TrailListingPresenter!

    init(trailRepository: TrailRepositoryProtocol) {
        self.repository = trailRepository
    }

    func getAllTrails() {
        repository.fetchTrailsAndRefresh(didRefresh: presenter.didGetAllTrails)
    }

    func initialFetch() {
        repository.initialFetch(didFetch: presenter.didGetAllTrails)
    }
}
