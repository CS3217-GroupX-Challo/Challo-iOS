//
//  TrailPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import CoreData
import Foundation
import MapKit

struct TrailPersistenceObject {
    let trailId: UUID
    let title: String
    let description: String
    let rating: Double
    let positions: [CLLocationCoordinate2D]
    let distance: Double
    let duration: Double
    let elevation: Double
    let images: [String]
    let area: Area
    let guideIds: [UUID]
    let numOfReviews: Int
    let lowestFee: Int
    let tags: [String]
    let landmarks: [String]
}

extension TrailPersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let trail = persistenceObject as? TrailDetails,
              let id = trail.id,
              let trailId = UUID(uuidString: id),
              let title = trail.title,
              let description = trail.descriptions,
              let positionsString = trail.positions,
              let imagesString = trail.images,
              let guideIdsString = trail.guideIds,
              let tagsString = trail.tags,
              let landmarksString = trail.landmarks,
              let areaObject = trail.area,
              let area = AreaPersistenceObject(persistenceObject: areaObject) else {
            return nil
        }
        
        self.trailId = trailId
        self.description = description
        self.title = title
        self.elevation = trail.elevation
        self.duration = trail.duration
        self.distance = trail.distance
        self.rating = trail.rating
        self.numOfReviews = Int(trail.numOfReviews)
        self.lowestFee = Int(trail.lowestFee)
        self.images = imagesString.constructArray()
        self.landmarks = landmarksString.constructArray()
        self.tags = tagsString.constructArray()
        
        let ids = guideIdsString.constructArray()
        var guideIdsArray = [UUID]()
        for idString in ids {
            if let id = UUID(uuidString: idString) {
                guideIdsArray.append(id)
            }
        }
        self.guideIds = guideIdsArray
        
        let positionsArray = positionsString.constructArray()
        var positions = [CLLocationCoordinate2D]()
        for positionString in positionsArray {
            if let position = CLLocationCoordinate2D(str: positionString) {
                positions.append(position)
            }
        }
        self.positions = positions
        
        let convertor = AreaModelConvertor()
        self.area = convertor.convertAreaPersistenceObjectToArea(areaObject: area)
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let trailDetails = TrailDetails(context: CoreDataContainer.managedObjectContext)
        setTrailDetails(trailDetails: trailDetails)
        return trailDetails
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let trailDetails = persistenceObject as? TrailDetails else {
            return
        }
        
        setTrailDetails(trailDetails: trailDetails)
    }
    
    private func setTrailDetails(trailDetails: TrailDetails) {
        trailDetails.descriptions = description
        trailDetails.distance = distance
        trailDetails.duration = duration
        trailDetails.images = String(array: images)
        trailDetails.title = title
        trailDetails.elevation = elevation
        trailDetails.guideIds = String(array: guideIds.map { $0.uuidString })
        trailDetails.id = trailId.uuidString
        trailDetails.landmarks = String(array: landmarks)
        trailDetails.lowestFee = Int64(lowestFee)
        trailDetails.numOfReviews = Int64(numOfReviews)
        trailDetails.positions = String(array: positions.map { $0.toString() })
        trailDetails.rating = rating
        trailDetails.tags = String(array: tags)
    }
}
