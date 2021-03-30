//
//  TrailRepositoryProtocol.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

protocol TrailRepositoryProtocol: Repository<Trail> {
    func fetchTrailsAndRefresh(didRefresh: (([Trail]) -> Void)?)
}

extension TrailRepositoryProtocol {
    func fetchTrailsAndRefresh() {
        fetchTrailsAndRefresh(didRefresh: nil)
    }
}
