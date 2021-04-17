//
//  TrailDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import CoreData

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
    
    func getAll() -> [TrailPersistenceObject] {
        let trails = repository.getAll()
        var trailObjects = [TrailPersistenceObject]()
        self.data = [NSManagedObjectID: TrailPersistenceObject]()
        
        for trail in trails {
            if let trailObject = TrailPersistenceObject(entity: trail) {
                trailObjects.append(trailObject)
                data[trail.objectID] = trailObject
            }
        }
        return trailObjects
    }
    
    func save(objects: [TrailPersistenceObject]) {
        let currentTrails = getAll()
        let currentAreas = areaRepository.getAll()
        
        let existingTrailObjects = objects.filter { trailObject in
            currentTrails.contains(trailObject)
        }
        
        let newTrailObjects = objects.filter { trailObject in
            !existingTrailObjects.contains(trailObject)
        }
        
        saveNewTrails(currentAreas: currentAreas, trailObjects: newTrailObjects)
        updateTrails(currentAreas: currentAreas, trailObjects: existingTrailObjects)
        repository.commit()
    }
    
    private func saveNewTrails(currentAreas: [AreaDetails], trailObjects: [TrailPersistenceObject]) {
        for trailObject in trailObjects {
            if let trailDetails = trailObject.convertToEntity() as? TrailDetails {
                for area in currentAreas where area.id == trailObject.area.areaId.uuidString {
                    trailDetails.area = area
                    break
                }
                
                if trailDetails.area == nil {
                    let area = trailObject.area.convertToEntity() as? AreaDetails
                    trailDetails.area = area
                }
            }
        }
    }
    
    private func updateTrails(currentAreas: [AreaDetails], trailObjects: [TrailPersistenceObject]) {
        for trailObject in trailObjects {
            if let objectId = data.first(where: { $0.value == trailObject })?.key,
               let trail = repository.getByKey(objectId) {
                trailObject.updateEntity(entity: trail)
                
                for area in currentAreas where area.id == trailObject.area.areaId.uuidString {
                    trail.area = area
                    break
                }
                
                if trail.area == nil {
                    let area = trailObject.area.convertToEntity() as? AreaDetails
                    trail.area = area
                }
            }
        }
    }
}
