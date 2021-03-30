//
//  MockAreaAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo

class MockAreaAPI: AreaAPI {
    typealias JSON = NetworkManager.JSON
    
    init() {
        super.init(areaParser: MockAreaAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }
    
    // mocking this function instead
    override func getAreas(url: String = "/area", callback: @escaping ([Area]) -> Void) {
        let mockAreas = [MockAreaAPIResponse.areaStateOne, MockAreaAPIResponse.areaStateTwo]
        callback(mockAreas)
    }
}
