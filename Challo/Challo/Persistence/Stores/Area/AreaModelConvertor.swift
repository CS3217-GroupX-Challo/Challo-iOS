//
//  AreaModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import Foundation

class AreaModelConvertor: ModelConvertor {
    typealias Model = Area
    typealias PersistenceObject = AreaPersistenceObject
    
    func convertModelToPersistenceObject(model: Area) -> AreaPersistenceObject {
        AreaPersistenceObject(areaId: model.areaId,
                              village: model.village,
                              division: model.division,
                              state: model.state,
                              country: model.country)
    }
    
    func convertPersistenceObjectToModel(object: AreaPersistenceObject) -> Area {
        Area(areaId: object.areaId,
             village: object.village,
             division: object.division,
             state: object.state,
             country: object.country)
    }
}
