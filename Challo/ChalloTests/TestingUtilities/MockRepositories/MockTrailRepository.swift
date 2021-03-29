//
//  MockTrailRepository.swift
//  ChalloTests
//
//  Created by Shao Yi on 29/3/21.
//

@testable import Challo

class MockTrailRepository: Repository<Trail>, TrailRepositoryProtocol {
    let trailAPI = MockTrailAPI()
    
    init() {
        super.init()
        fetchTrailsAndRefresh()
    }
    
    private func refreshTrails(_ trails: [Trail]) {
        for trail in trails {
            upsert(entity: trail, key: trail.trailId)
        }
    }
    
    func fetchTrailsAndRefresh() {
        trailAPI.getTrails { [weak self] trails in
            self?.refreshTrails(trails)
        }
    }
}
