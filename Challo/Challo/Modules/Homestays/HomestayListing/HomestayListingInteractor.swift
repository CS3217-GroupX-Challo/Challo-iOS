//
//  HomestayListingInteractor.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import Foundation

class HomestayListingInteractor: EntityListingInteractor {

    var repository: HomestayRepositoryProtocol
    weak var presenter: HomestayListingPresenter!

    init(homestayRepository: HomestayRepositoryProtocol) {
        self.repository = homestayRepository
    }

    func getAllEntities() {
        repository.fetchHomestaysAndRefresh(didRefresh: presenter.didGetAllEntities)
    }

    func getCachedEntities() -> [Homestay] {
        repository.getAll()
    }

    func initialFetch() {
        getAllEntities()
    }
}
