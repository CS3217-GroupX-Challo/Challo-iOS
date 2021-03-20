//
//  AreaAPI.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

class AreaAPI {

    let areaParser = AreaAPIParser()

    func getAreas(url: String = "/area", callback: @escaping ([Area]) -> Void) {
        let api = AlamofireManager.alamofireManager
        api.get(url: url,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            let areas = self.areaParser.parseAreas(response: response)
            callback(areas)
        }
    }
}
