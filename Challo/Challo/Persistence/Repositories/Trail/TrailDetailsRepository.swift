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
    }
}
