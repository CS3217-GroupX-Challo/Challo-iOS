//
//  HomestayAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation

class HomestayAPI: HomestayAPIProtocol {

    typealias JSON = NetworkManager.JSON

    private let homestayParser: HomestayAPIParser
    private let networkManager: NetworkManager

    private let baseUrl = "/homestay"

    init(homestayParser: HomestayAPIParser, networkManager: NetworkManager) {
        self.homestayParser = homestayParser
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
            
            let homestays = self.homestayParser.parseHomestays(response: response)
            callback(homestays)
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
            
            guard let homestayInfo = response["data"] as? JSON,
                  let homestay = self.homestayParser.convertJSONToHomestay(json: homestayInfo) else {
                callback(nil)
                return
            }
            
            callback(homestay)
        }
    }
}
