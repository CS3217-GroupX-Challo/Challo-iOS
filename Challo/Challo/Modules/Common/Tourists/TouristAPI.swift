//
//  TouristAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

class TouristAPI: TouristAPIProtocol {

    typealias JSON = NetworkManager.JSON
    private let touristParser: TouristAPIParser
    private let networkManager: NetworkManager
    
    init(touristParser: TouristAPIParser, networkManager: NetworkManager) {
        self.touristParser = touristParser
        self.networkManager = networkManager
    }

    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        networkManager.get(url: url + "/" + userId.uuidString,
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
