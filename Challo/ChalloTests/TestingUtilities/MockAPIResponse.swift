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
        guard var data = json["data"] as? JSON else {
            return JSON()
        }
        _ = data.removeValue(forKey: key)
        var newJson = json
        newJson["data"] = data
        return newJson
    }
}
