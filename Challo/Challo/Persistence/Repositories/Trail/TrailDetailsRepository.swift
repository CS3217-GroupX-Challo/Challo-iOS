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
        return []
    }
    
    func saveTrails(trailObjects: [TrailPersistenceObject]) {
    }
}
