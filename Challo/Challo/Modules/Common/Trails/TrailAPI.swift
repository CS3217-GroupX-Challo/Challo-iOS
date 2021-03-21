//
//  TrailsAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

class TrailAPI {

    typealias JSON = NetworkManager.JSON
    let parser = TrailAPIParser()

    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        let api = APINetwork.api
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
    
    func getAllTrails(callback: @escaping ([Trail]) -> Void) {
        let api = AlamofireManager.alamofireManager
        api.get(url: "/trail",
                headers: [String: String]()) { [weak self] response, error in
            if error != nil {
                return
            }
            guard let trails = self?.parser.parseTrail(response: response) else {
                return
            }
            
            callback(trails)
        }
    }
}
