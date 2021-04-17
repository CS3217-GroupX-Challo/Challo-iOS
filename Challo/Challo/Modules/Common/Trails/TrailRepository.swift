//
//  TrailRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Foundation

class TrailRepository: Repository<UUID, Trail>, TrailRepositoryProtocol, LocalStorageRetriever {
    
    typealias Model = Trail
    typealias LocalStore = TrailStore

    let trailAPI: TrailAPIProtocol
    let localStore: TrailStore
    var isInitialized: Bool = false
    
    init(trailAPI: TrailAPIProtocol,
         trailStore: TrailStore) {
        self.trailAPI = trailAPI
        self.localStore = trailStore
        super.init()
        fetchTrailsAndRefresh()
    }
    
    private func refreshTrails(_ trails: [Trail]) {
        for trail in trails {
            upsert(entity: trail, key: trail.trailId)
        }
    }
    
    func fetchTrailsAndRefresh(didRefresh: (([Trail]) -> Void)? = nil) {
        trailAPI.getTrails { [weak self] trails in
            self?.refreshTrails(trails)
            didRefresh?(trails)
        }
    }

    func initialFetch(didFetch: @escaping (([Trail]) -> Void)) {
        if isInitialized {
            didFetch(self.getAll())
            return
        }
        fetchTrailsAndRefresh { trails in
            self.isInitialized = true

            if trails.isEmpty {
                let localTrails = self.retrieveFromLocalStore()
                self.refreshTrails(localTrails)
                didFetch(localTrails)
                return
            }
            
            didFetch(trails)
        }
    }
}
