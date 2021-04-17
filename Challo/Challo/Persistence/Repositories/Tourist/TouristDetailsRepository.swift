//
//  TouristDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import CoreData
import Foundation

class TouristDetailsRepository: TouristDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: TouristPersistenceObject]
    var repository: CoreDataRepository<TouristDetails>
    
    init(data: [NSManagedObjectID: TouristPersistenceObject],
         repository: CoreDataRepository<TouristDetails>) {
        self.data = data
        self.repository = repository
    }
    
    init() {
        self.data = [NSManagedObjectID: TouristPersistenceObject]()
        self.repository = CoreDataRepository<TouristDetails>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
    }
    
    func getAll() -> [TouristPersistenceObject] {
        let tourists = repository.getAll()
        var touristObjects = [TouristPersistenceObject]()
        self.data = [NSManagedObjectID: TouristPersistenceObject]()
        
        for tourist in tourists {
            if let touristObject = TouristPersistenceObject(entity: tourist) {
                data[tourist.objectID] = touristObject
                touristObjects.append(touristObject)
            }
        }
        
        return touristObjects
    }
    
    func save(objects: [TouristPersistenceObject]) {
        let currentTouristObjects = getAll()
        
        let existingTouristObjects = objects.filter { touristObject in
            currentTouristObjects.contains(touristObject)
        }
        
        let newTouristObjects = objects.filter {touristObject in
            !existingTouristObjects.contains(touristObject)
        }
        
        createNewTourists(touristObjects: newTouristObjects)
        updateTourists(touristObjects: existingTouristObjects)
        repository.commit()
    }
        
    private func createNewTourists(touristObjects: [TouristPersistenceObject]) {
        for touristObject in touristObjects {
            _ = touristObject.convertToEntity()
        }
    }
    
    private func updateTourists(touristObjects: [TouristPersistenceObject]) {
        for touristObject in touristObjects {
            if let objectId = data.first(where: { $0.value == touristObject })?.key,
               let tourist = repository.getByKey(objectId) {
                touristObject.updateEntity(entity: tourist)
            }
        }
    }
}
