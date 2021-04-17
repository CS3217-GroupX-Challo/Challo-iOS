//
//  HostAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation

class HostAPI {

    typealias JSON = NetworkManager.JSON
    private let hostParser: HostAPIParser
    private let networkManager: NetworkManager

    private let baseUrl = "/host"
    
    init(hostParser: HostAPIParser, networkManager: NetworkManager) {
        self.hostParser = hostParser
        self.networkManager = networkManager
    }

    func getHost(userId: UUID, callback: @escaping (Host?) -> Void) {
        networkManager.get(url: baseUrl + "/" + userId.uuidString,
                           headers: [String: String]()) { [weak self] response, error in
            if error != nil {
                callback(nil)
                return
            }
            
            guard let hostInfo = response["data"] as? JSON else {
                callback(nil)
                return
            }
            
            guard let host = self?.hostParser.convertJSONToHost(json: hostInfo) else {
                callback(nil)
                return
            }
            
            callback(host)
        }
    }
}
