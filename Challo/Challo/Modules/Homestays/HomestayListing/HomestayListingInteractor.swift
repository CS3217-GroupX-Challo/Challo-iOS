//
//  HomestayListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import Foundation

class HomestayListingInteractor: EntityListingInteractor {
    typealias Entity = Homestay
    
    var repository: Repository<UUID, Homestay> & FetchableRepository
    weak var presenter: HomestayListingPresenter!

    init(homestayRepository: HomestayRepositoryProtocol) {
        self.repository = homestayRepository
    }
    
    func initialFetch() {
        getAllEntities()
    }
}
