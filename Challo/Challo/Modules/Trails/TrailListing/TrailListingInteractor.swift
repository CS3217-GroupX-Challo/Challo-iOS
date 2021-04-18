//
//  TrailListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

class TrailListingInteractor: EntityListingInteractor {

    typealias Entity = Trail
    
    var repository: Repository<UUID, Trail> & FetchableRepository
    weak var presenter: TrailListingPresenter!

    init(trailRepository: TrailRepositoryProtocol) {
        self.repository = trailRepository
    }

}
