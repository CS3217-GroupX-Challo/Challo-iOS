//
//  TrailRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

protocol TrailRepositoryProtocol: Repository<UUID, Trail>, FetchableRepository {
    func fetchTrailsAndRefresh(didRefresh: (([Trail]) -> Void)?)
}

extension TrailRepositoryProtocol {
    func fetchTrailsAndRefresh() {
        fetchTrailsAndRefresh(didRefresh: nil)
    }
}
