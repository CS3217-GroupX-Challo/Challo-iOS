//
//  TrailModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

class TrailModelConvertor: ModelConvertor {
    typealias Model = Trail
    typealias PersistenceObject = TrailPersistenceObject
    
    let convertor: AreaModelConvertor
    
    init(convertor: AreaModelConvertor) {
        self.convertor = convertor
    }
    
    func convertModelToPersistenceObject(model: Trail) -> TrailPersistenceObject {
        let areaObject = convertor.convertModelToPersistenceObject(model: model.area)
        return TrailPersistenceObject(trailId: model.trailId, title: model.title,
                                      description: model.description, rating: model.rating,
                                      positions: model.positions, distance: model.distance,
                                      duration: model.duration, elevation: model.elevation,
                                      images: model.images, area: areaObject,
                                      guideIds: model.guideIds, numOfReviews: model.numOfReviews,
                                      lowestFee: model.lowestFee, tags: model.tags,
                                      landmarks: model.landmarks,
                                      difficulty: model.difficulty)
    }
    
    func convertPersistenceObjectToModel(object: TrailPersistenceObject) -> Trail {
        let area = convertor.convertPersistenceObjectToModel(object: object.area)
        return Trail(trailId: object.trailId, title: object.title,
                     description: object.description, rating: object.rating,
                     difficulty: object.difficulty,
                     positions: object.positions, distance: object.distance,
                     duration: object.duration, elevation: object.elevation,
                     images: object.images, area: area,
                     guideIds: object.guideIds, numOfReviews: object.numOfReviews,
                     lowestFee: object.lowestFee, tags: object.tags,
                     landmarks: object.landmarks)
    }
}
