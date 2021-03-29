//
//  TrailRepository.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

class TrailRepository: Repository<Trail> {
    let trailAPI = TrailAPI()
    
    private func refreshTrails(_ trails: [Trail]) {
        for trail in trails {
            upsert(entity: trail, key: trail.trailId)
        }
    }
    
    func fetchTrailsAndRefresh() {
        trailAPI.getAllTrails { [weak self] trails in
            self?.refreshTrails(trails)
        }
    }
}
