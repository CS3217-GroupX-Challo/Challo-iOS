//
//  MockNetworkManager.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockNetworkManager: NetworkManager {
    typealias JSON = NetworkManager.JSON
    
    let parser: APIParser
    let json: JSON
    
    init(parser: APIParser, json: JSON) {
        self.parser = parser
        self.json = json
    }
    
    func get(url: String, headers: HEADER, responseHandler: @escaping (JSON, Error?) -> Void) {
        responseHandler(json, nil)
    }
    
    func post(url: String, headers: HEADER, body: JSON, responseHandler: @escaping (JSON, Error?) -> Void) {
        responseHandler(json, nil)
    }
    
    func put(url: String, headers: HEADER, body: JSON, responseHandler: @escaping (JSON, Error?) -> Void) {
        responseHandler(json, nil)
    }
    
    func delete(url: String, headers: HEADER, responseHandler: @escaping (JSON, Error?) -> Void) {
        responseHandler(json, nil)
    }
}
