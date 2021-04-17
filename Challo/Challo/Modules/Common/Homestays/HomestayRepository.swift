//
//  HomestayRepository.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation

class HomestayRepository: Repository<UUID, Homestay>, HomestayRepositoryProtocol {
    
    private let homestayAPI: HomestayAPIProtocol

    init(homestayAPI: HomestayAPIProtocol) {
        self.homestayAPI = homestayAPI
        super.init()
    }

    func fetchHomestaysAndRefresh(didRefresh: (([Homestay]) -> Void)?) {
        homestayAPI.getHomestays { [weak self] homestays in
            self?.refreshHomestays(homestays)
            didRefresh?(homestays)
        }
    }

    private func refreshHomestays(_ homestays: [Homestay]) {
        for homestay in homestays {
            upsert(entity: homestay, key: homestay.homestayId)
        }
    }
}
