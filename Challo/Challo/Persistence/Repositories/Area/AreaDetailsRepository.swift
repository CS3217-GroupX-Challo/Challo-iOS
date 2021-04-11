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
    private var repository: CoreDataRepository<AreaDetails>
    
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
    
    func getAllAreas() -> [AreaPersistenceObject] {
        let areas = repository.getAll()
        var areaObjects = [AreaPersistenceObject]()
        self.data = [NSManagedObjectID: AreaPersistenceObject]() // reset
        
        for area in areas {
            if let areaObject = AreaPersistenceObject(persistenceObject: area) {
                data[area.objectID] = areaObject
                areaObjects.append(areaObject)
            }
        }
        
        return areaObjects
    }
    
    func saveAreas(areaObjects: [AreaPersistenceObject]) {
        let currentAreaObjects = getAllAreas()
        
        let existingAreaObjects = areaObjects.filter { areaObject in
            currentAreaObjects.contains(areaObject)
        }
        
        let newAreaObjects = areaObjects.filter { areaObject in
            !existingAreaObjects.contains(areaObject)
        }
        
        createNewAreas(areaObjects: newAreaObjects)
        updateAreas(areaObjects: existingAreaObjects)
        repository.commit() // units of work pattern
    }
    
    private func createNewAreas(areaObjects: [AreaPersistenceObject]) {
        for areaObject in areaObjects {
            // result not needed as entity row alr created, waiting to be committed
            let _ = areaObject.convertToPersistenceObject()
        }
    }
    
    private func updateAreas(areaObjects: [AreaPersistenceObject]) {
        for areaObject in areaObjects {
            if let objectId = data.first(where: { $0.value == areaObject })?.key,
               let area = repository.getByKey(objectId) {
                areaObject.updatePersistenceObject(persistenceObject: area)
            }
        }
    }
}
