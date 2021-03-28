//
//  MockTouristAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 28/3/21.
//

import Foundation
@testable import Challo

class MockTouristAPI: TouristAPI {
    typealias JSON = NetworkManager.JSON
    
    init() {
        super.init(touristParser: MockTouristAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    override func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        callback(MockTouristAPIResponse.tourist)
    }
}
