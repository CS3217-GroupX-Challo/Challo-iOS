//
//  MockTrailAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

import Foundation
@testable import Challo

class MockTrailAPI: TrailAPI {
    
    init() {
        super.init(parser: MockTrailAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    override func getTrails(callback: @escaping ([Trail]) -> Void) {
        let trails = [MockTrailAPIResponse.trailOne, MockTrailAPIResponse.trailTwo]
        callback(trails.compactMap { $0 })
    }

    override func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        guard let mockTrail = MockTrailAPIResponse.trailOne else {
            return
        }
        callback(mockTrail)
    }
}
