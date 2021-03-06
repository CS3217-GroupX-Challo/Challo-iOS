//
//  AreaDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import CoreData
import Foundation

class AreaDetailsRepository: AreaDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: AreaPersistenceObject]
    var repository: CoreDataRepository<AreaDetails>
    
    init(data: [NSManagedObjectID: AreaPersistenceObject],
         repository: CoreDataRepository<AreaDetails>) {
        self.data = data
        self.repository = repository
    }
    
    init() {
        self.data = [NSManagedObjectID: AreaPersistenceObject]()
        self.repository = CoreDataRepository<AreaDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
    }
    
    func getAll() -> [AreaPersistenceObject] {
        let areas = repository.getAll()
        var areaObjects = [AreaPersistenceObject]()
        self.data = [NSManagedObjectID: AreaPersistenceObject]() // reset
        
        for area in areas {
            if let areaObject = AreaPersistenceObject(entity: area) {
                data[area.objectID] = areaObject
                areaObjects.append(areaObject)
            }
        }
        
        return areaObjects
    }
    
    func save(objects: [AreaPersistenceObject]) {
        let uniqueObjects = getUniqueAreas(objects: objects)

        let currentAreaObjects = getAll()
        
        let existingAreaObjects = uniqueObjects.filter { areaObject in
            currentAreaObjects.contains(areaObject)
        }
        
        let newAreaObjects = uniqueObjects.filter { areaObject in
            !existingAreaObjects.contains(areaObject)
        }
        
        createNewAreas(areaObjects: newAreaObjects)
        updateAreas(areaObjects: existingAreaObjects)
        repository.commit() // units of work pattern
    }

    private func getUniqueAreas(objects: [AreaPersistenceObject]) -> [AreaPersistenceObject] {
        var uniqueId = Set<UUID>()
        var uniqueObjects = [AreaPersistenceObject]()

        objects.forEach {
            if uniqueId.contains($0.areaId) {
                return
            }
            uniqueId.insert($0.areaId)
            uniqueObjects.append($0)
        }
        
        return uniqueObjects
    }
    
    private func createNewAreas(areaObjects: [AreaPersistenceObject]) {
        for areaObject in areaObjects {
            // result not needed as entity row alr created, waiting to be committed
            _ = areaObject.convertToEntity()
        }
    }
    
    private func updateAreas(areaObjects: [AreaPersistenceObject]) {
        for areaObject in areaObjects {
            if let objectId = data.first(where: { $0.value == areaObject })?.key,
               let area = repository.getByKey(objectId) {
                areaObject.updateEntity(entity: area)
            }
        }
    }
}
