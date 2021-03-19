//
//  TrailsAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

protocol TrailAPI: TrailAPIInteractor {
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String)
}

extension TrailAPI {
    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + "/" + trailId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            guard let trailInfo = response["data"] as? JSON,
                  let trail = convertJSONToTrail(json: trailInfo) else {
                return
            }
            
            callback(trail)
        }
    }
}
