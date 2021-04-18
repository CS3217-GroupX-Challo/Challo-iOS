//
//  MockTrailRepository.swift
//  ChalloTests
//
//  Created by Shao Yi on 29/3/21.
//

@testable import Challo
import Foundation

class MockTrailRepository: Repository<UUID, Trail>, TrailRepositoryProtocol {

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
    
    func fetchTrailsAndRefresh(didRefresh: (([Trail]) -> Void)? = nil) {
        trailAPI.getTrails { [weak self] trails in
            self?.refreshTrails(trails)
            didRefresh?(trails)
        }
    }
    
    func fetchAllAndRefresh(didRefresh: (() -> Void)?) {
        fetchTrailsAndRefresh(didRefresh: { _ in didRefresh?() })
    }
    
    func initialFetch(didFetch: (() -> Void)?) {
        fetchTrailsAndRefresh(didRefresh: { _ in didFetch?() })
    }
}
