//
//  AreaAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

class AreaAPI {

    private let areaParser: AreaAPIParser
    private let networkManager: NetworkManager
    
    init(areaParser: AreaAPIParser, networkManager: NetworkManager) {
        self.areaParser = areaParser
        self.networkManager = networkManager
    }

    func getAreas(url: String = "/area", callback: @escaping ([Area]) -> Void) {
        networkManager.get(url: url,
                           headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            let areas = self.areaParser.parseAreas(response: response)
            callback(areas)
        }
    }
}
