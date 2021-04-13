//
//  AreaModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import Foundation

class AreaModelConvertor {
    func convertAreaToAreaPersistenceObject(area: Area) -> AreaPersistenceObject {
        AreaPersistenceObject(areaId: area.areaId,
                              village: area.village,
                              division: area.division,
                              state: area.state,
                              country: area.country)
    }
    
    func convertAreaPersistenceObjectToArea(areaObject: AreaPersistenceObject) -> Area {
        Area(areaId: areaObject.areaId,
             village: areaObject.village,
             division: areaObject.division,
             state: areaObject.state,
             country: areaObject.country)
    }
}
