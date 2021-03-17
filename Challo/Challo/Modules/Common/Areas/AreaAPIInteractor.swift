//
//  AreaAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import Foundation

protocol AreaAPIInteractor {
    typealias JSON = AlamofireManager.JSON
    
    func parseAreas(response: JSON) -> [Area]
}

extension AreaAPIInteractor {
    func parseAreas(response: JSON) -> [Area] {
        guard let data = response["data"],
              let areasInfo = data as? [JSON] else {
            return []
        }
        
        var areas = [Area]()
        for areaInfo in areasInfo {
            if let area = convertJSONToArea(json: areaInfo) {
                areas.append(area)
            }
        }
        return areas
    }
    
    func convertJSONToArea(json: JSON) -> Area? {
        guard let areaId = UUID(uuidString: json[Key.areaId] as? String ?? ""),
              let country = json[Key.country] as? String,
              let state = json[Key.state] as? String else {
            return nil
        }
        
        return Area(areaId: areaId,
                    areaName: state,
                    regionName: country)
    }
}
