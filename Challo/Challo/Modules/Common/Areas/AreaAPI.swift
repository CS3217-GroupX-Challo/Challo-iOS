//
//  AreaAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

protocol AreaAPI: AreaAPIInteractor {
    func getAreas(url: String, callback: @escaping ([Area]) -> Void)
}

extension AreaAPI {
    func getAreas(url: String = "/area", callback: @escaping ([Area]) -> Void) {
        let api = AlamofireManager.alamofireManager
        api.get(url: url,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            let areas = self.parseAreas(response: response)
            callback(areas)
        }
    }
}
