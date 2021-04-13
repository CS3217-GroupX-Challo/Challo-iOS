//
//  TrailListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

class TrailListingInteractor: InteractorProtocol {

    private var trailRepository: TrailRepositoryProtocol
    weak var presenter: TrailListingPresenter!

    init(trailRepository: TrailRepositoryProtocol) {
        self.trailRepository = trailRepository
    }

    func getAllTrails() {
        trailRepository.fetchTrailsAndRefresh(didRefresh: presenter.didGetAllTrails)
    }

    func getCachedTrails() -> [Trail] {
        trailRepository.getAll()
    }
}
