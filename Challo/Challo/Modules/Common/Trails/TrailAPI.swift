//
//  TrailsAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

class TrailAPI {

    typealias JSON = AlamofireManager.JSON
    let parser = TrailAPIParser()

    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + "/" + trailId.uuidString,
                headers: [String: String]()) { [weak self] response, error in
            if error != nil {
                return
            }
            
            guard let trailInfo = response["data"] as? JSON,
                  let trail = self?.parser.convertJSONToTrail(json: trailInfo) else {
                return
            }
            
            callback(trail)
        }
    }
}
