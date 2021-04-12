//
//  TrailDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import CoreData
import Foundation

class TrailDetailsRepository: TrailDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: TrailPersistenceObject]
    private var repository: CoreDataRepository<TrailDetails>
    private var areaRepository: CoreDataRepository<AreaDetails>
    
    init(data: [NSManagedObjectID: TrailPersistenceObject],
         repository: CoreDataRepository<TrailDetails>,
         areaRepository: CoreDataRepository<AreaDetails>) {
        self.data = data
        self.repository = repository
        self.areaRepository = areaRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: TrailPersistenceObject]()
        self.repository = CoreDataRepository<TrailDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.areaRepository = CoreDataRepository<AreaDetails>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
    }
    
    func getAllTrails() -> [TrailPersistenceObject] {
        let trails = repository.getAll()
        var trailObjects = [TrailPersistenceObject]()
        self.data = [NSManagedObjectID: TrailPersistenceObject]()
        
        for trail in trails {
            if let trailObject = TrailPersistenceObject(persistenceObject: trail) {
                trailObjects.append(trailObject)
                data[trail.objectID] = trailObject
            }
        }
        return trailObjects
    }
    
    func saveTrails(trailObjects: [TrailPersistenceObject]) {
        let currentTrails = getAllTrails()
        let currentAreas = areaRepository.getAll()
        
        let existingTrailObjects = trailObjects.filter { trailObject in
            currentTrails.contains(trailObject)
        }
        
        let newTrailObjects = trailObjects.filter { trailObject in
            !existingTrailObjects.contains(trailObject)
        }
        
        saveNewTrail(currentAreas: currentAreas, trailObjects: newTrailObjects)
        updateTrails(currentAreas: currentAreas, trailObjects: existingTrailObjects)
        repository.commit()
    }
    
    private func saveNewTrail(currentAreas: [AreaDetails], trailObjects: [TrailPersistenceObject]) {
        for trailObject in trailObjects {
            if let trailDetails = trailObject.convertToPersistenceObject() as? TrailDetails {
                for area in currentAreas where area.id == trailObject.area.areaId.uuidString {
                    trailDetails.area = area
                    break
                }
                
                // save new area
                if trailDetails.area == nil {
                    let area = trailObject.area.convertToPersistenceObject() as? AreaDetails
                    trailDetails.area = area
                }
            }
        }
    }
    
    private func updateTrails(currentAreas: [AreaDetails], trailObjects: [TrailPersistenceObject]) {
        for trailObject in trailObjects {
            if let objectId = data.first(where: { $0.value == trailObject })?.key,
               let trail = repository.getByKey(objectId) {
                trailObject.updatePersistenceObject(persistenceObject: trail)
                
                for area in currentAreas where area.id == trailObject.area.areaId.uuidString {
                    trail.area = area
                    break
                }
                
                // save new area
                if trail.area == nil {
                    let area = trailObject.area.convertToPersistenceObject() as? AreaDetails
                    trail.area = area
                }
            }
        }
    }
}
