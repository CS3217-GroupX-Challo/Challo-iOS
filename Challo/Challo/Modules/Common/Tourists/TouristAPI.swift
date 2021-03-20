//
//  TouristAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

class TouristAPI {

    typealias JSON = NetworkManager.JSON
    let touristParser = TouristAPIParser()

    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        let api = APINetwork.api
        api.get(url: url + "/" + userId.uuidString,
                headers: [String: String]()) { [weak self] response, error in
            if error != nil {
                return
            }
            
            guard let touristInfo = response["data"] as? JSON else {
                return
            }
            
            guard let tourist = self?.touristParser.convertJSONToTourist(json: touristInfo) else {
                return
            }
            
            callback(tourist)
        }
    }
}
