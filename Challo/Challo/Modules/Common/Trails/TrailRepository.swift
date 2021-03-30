//
//  TrailRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

class TrailRepository: Repository<Trail>, TrailRepositoryProtocol {
    let trailAPI: TrailAPIProtocol
    
    init(trailAPI: TrailAPIProtocol) {
        self.trailAPI = trailAPI
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
}
