//
//  MockTrailAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockTrailAPI: TrailAPI {
    
    init() {
        super.init(parser: TrailAPIParser(),
                   networkManager: APINetwork.getNetworkManager())
    }
    
    override func getAllTrails(callback: @escaping ([Trail]) -> Void) {
        let trails = [MockTrailAPIResponse.trailOne, MockTrailAPIResponse.trailTwo]
        callback(trails.compactMap { $0 })
    }
}
