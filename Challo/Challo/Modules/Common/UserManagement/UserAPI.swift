//
//  UserAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

protocol UserAPI: UserAPIInteractor {
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String)
}

extension UserAPI {
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + "/" + userId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            guard let touristInfo = response["data"] as? JSON else {
                return
            }
            
            guard let tourist = convertJSONToTourist(json: touristInfo) else {
                return
            }
            
            callback(tourist)
        }
    }
}
