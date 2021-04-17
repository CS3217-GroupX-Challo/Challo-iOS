//
//  TrailsAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//
import Foundation

class TrailAPI: TrailAPIProtocol {

    typealias JSON = NetworkManager.JSON
    private let parser: TrailAPIParser
    private let networkManager: NetworkManager
    
    init(parser: TrailAPIParser, networkManager: NetworkManager) {
        self.parser = parser
        self.networkManager = networkManager
    }

    func getTrail(trailId: UUID, callback: @escaping (Trail) -> Void, url: String = "/trail") {
        networkManager.get(url: url + "/" + trailId.uuidString,
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
    
    func getTrails(callback: @escaping ([Trail]) -> Void) {
        networkManager.get(url: "/trail",
                           headers: [String: String]()) { [weak self] response, error in
            if error != nil {
                callback([])
                return
            }
            guard let trails = self?.parser.parseTrail(response: response) else {
                callback([])
                return
            }
            
            callback(trails)
        }
    }
}
