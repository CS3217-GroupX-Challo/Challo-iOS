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
    var repository: CoreDataRepository<TrailDetails>
    private var areaRepository: AreaDetailsRepository
    
    init(data: [NSManagedObjectID: TrailPersistenceObject],
         repository: CoreDataRepository<TrailDetails>,
         areaRepository: AreaDetailsRepository) {
        self.data = data
        self.repository = repository
        self.areaRepository = areaRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: TrailPersistenceObject]()
        self.repository = CoreDataRepository<TrailDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.areaRepository = AreaDetailsRepository()
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
        var uniqueId = Set<UUID>()
        var uniqueObjects = [TrailPersistenceObject]()

        objects.forEach {
            if uniqueId.contains($0.trailId) {
                return
            }
            uniqueId.insert($0.trailId)
            uniqueObjects.append($0)
        }

        let allAreas = objects.map { $0.area }
        areaRepository.save(objects: allAreas)
    
        let currentTrails = getAll()
        let currentAreas = areaRepository.repository.getAll()
        
        let existingTrailObjects = uniqueObjects.filter { trailObject in
            currentTrails.contains(trailObject)
        }
        
        let newTrailObjects = uniqueObjects.filter { trailObject in
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
            }
        }
    }
}
