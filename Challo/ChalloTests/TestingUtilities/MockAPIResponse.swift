//
//  MockAPIResponse.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo

protocol MockAPIResponse {
    typealias JSON = NetworkManager.JSON
}

extension MockAPIResponse {
    static func removeUserProperty(key: String, json: JSON) -> JSON {
        var newJson = json
        _ = newJson.removeValue(forKey: key)
        return newJson
    }
}
