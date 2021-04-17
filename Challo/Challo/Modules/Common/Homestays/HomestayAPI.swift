//
//  HomestayAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import Dispatch

class HomestayAPI: HomestayAPIProtocol {

    typealias JSON = NetworkManager.JSON

    private let homestayParser: HomestayAPIParser
    private let hostAPI: HostAPIProtocol
    private let networkManager: NetworkManager

    private let baseUrl = "/homestay"

    init(homestayParser: HomestayAPIParser,
         hostAPI: HostAPIProtocol,
         networkManager: NetworkManager) {
        self.homestayParser = homestayParser
        self.hostAPI = hostAPI
        self.networkManager = networkManager
    }

    func getHomestays(callback: @escaping ([Homestay]) -> Void) {
        networkManager.get(url: baseUrl,
                           headers: [String: String]()) { [weak self] response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                callback([])
                return
            }
            
            let homestayData = self.homestayParser.extractHomestayJSON(response: response)
            
            var homestays = [Homestay]()
            let group = DispatchGroup()
            for _ in 0..<homestayData.count {
                group.enter()
            }
            
            for data in homestayData {
                self.handleHomestayJson(json: data) { homestay in
                    homestay.map { homestays.append($0) }
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                callback(homestays)
            }
        }
    }

    func getHomestay(homestayId: UUID,
                     callback: @escaping (Homestay?) -> Void) {
        networkManager.get(url: "\(baseUrl)/\(homestayId.uuidString)",
                           headers: [String: String]()) { [weak self] response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                callback(nil)
                return
            }
            
            guard let homestayInfo = response["data"] as? JSON else {
                callback(nil)
                return
            }
            
            self.handleHomestayJson(json: homestayInfo) { homestay in
                callback(homestay)
            }
        }
    }
}

// MARK: Private
extension HomestayAPI {

    func handleHomestayJson(json: JSON,
                            callback: @escaping (Homestay?) -> Void) {
        guard let hostId = self.homestayParser.extractHostId(json: json) else {
            callback(nil)
            return
        }
        
        hostAPI.getHost(userId: hostId) { [weak self] host in
            guard let host = host,
                  let self = self else {
                callback(nil)
                return
            }
            
            guard let homestay = self.homestayParser.convertJSONToHomestay(json: json,
                                                                           host: host) else {
                callback(nil)
                return
            }
            
            callback(homestay)
        }
    }
}
