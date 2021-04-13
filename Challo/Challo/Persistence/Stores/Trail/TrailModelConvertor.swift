//
//  TrailModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

struct TrailModelConvertor {
    let convertor: AreaModelConvertor
    
    func convertTrailToTrailPersistenceObject(trail: Trail) -> TrailPersistenceObject {
        let areaObject = convertor.convertAreaToAreaPersistenceObject(area: trail.area)
        return TrailPersistenceObject(trailId: trail.trailId, title: trail.title,
                                      description: trail.description, rating: trail.rating,
                                      positions: trail.positions, distance: trail.distance,
                                      duration: trail.duration, elevation: trail.elevation,
                                      images: trail.images, area: areaObject,
                                      guideIds: trail.guideIds, numOfReviews: trail.numOfReviews,
                                      lowestFee: trail.lowestFee, tags: trail.tags,
                                      landmarks: trail.landmarks,
                                      difficulty: trail.difficulty)
    }
    
    func convertTrailPersistenceObjectToTrail(trailObject: TrailPersistenceObject) -> Trail {
        let area = convertor.convertAreaPersistenceObjectToArea(areaObject: trailObject.area)
        return Trail(trailId: trailObject.trailId, title: trailObject.title,
                     description: trailObject.description, rating: trailObject.rating,
                     difficulty: trailObject.difficulty,
                     positions: trailObject.positions, distance: trailObject.distance,
                     duration: trailObject.duration, elevation: trailObject.elevation,
                     images: trailObject.images, area: area,
                     guideIds: trailObject.guideIds, numOfReviews: trailObject.numOfReviews,
                     lowestFee: trailObject.lowestFee, tags: trailObject.tags,
                     landmarks: trailObject.landmarks)
    }
}
