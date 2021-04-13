//
//  AreaAPIParser.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import Foundation

class AreaAPIParser: APIParser {

    typealias JSON = NetworkManager.JSON
    
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
              let village = json[Key.village] as? String,
              let country = json[Key.country] as? String,
              let division = json[Key.division] as? String,
              let state = json[Key.state] as? String else {
            return nil
        }
        
        return Area(areaId: areaId,
                    village: village,
                    division: division,
                    state: state,
                    country: country)
    }

    func convertAreaToJSON(area: Area) -> JSON {
        var json = JSON()
        json[Key.areaId] = area.areaId.uuidString
        json[Key.village] = area.village
        json[Key.division] = area.division
        json[Key.state] = area.state
        json[Key.country] = area.country
        return json
    }
}
