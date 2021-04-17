//
//  HostDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 18/4/21.
//

import CoreData

class HostDetailsRepository: HostDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: HostPersistenceObject]
    private var repository: CoreDataRepository<HostDetails>
    
    init(data: [NSManagedObjectID: HostPersistenceObject],
         repository: CoreDataRepository<HostDetails>) {
        self.data = data
        self.repository = repository
    }
    
    init() {
        self.data = [NSManagedObjectID: HostPersistenceObject]()
        self.repository = CoreDataRepository<HostDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
    }
    
    func getAll() -> [HostPersistenceObject] {
        let hosts = repository.getAll()
        var hostObjects = [HostPersistenceObject]()
        self.data = [NSManagedObjectID: HostPersistenceObject]()
        
        for host in hosts {
            if let hostObject = HostPersistenceObject(entity: host) {
                data[host.objectID] =  hostObject
                hostObjects.append(hostObject)
            }
        }
        
        return hostObjects
    }
    
    func save(objects: [HostPersistenceObject]) {
        let currentHostObjects = getAll()
        
        let existingHostObjects = objects.filter { hostObject in
            currentHostObjects.contains(hostObject)
        }
        
        let newHostObjects = objects.filter { hostObject in
            !currentHostObjects.contains(hostObject)
        }
        
        createNewHosts(hostObjects: newHostObjects)
        updateHosts(hostObjects: existingHostObjects)
        repository.commit()
    }
    
    private func createNewHosts(hostObjects: [HostPersistenceObject]) {
        for hostObject in hostObjects {
            _ = hostObject.convertToEntity()
        }
    }
    
    private func updateHosts(hostObjects: [HostPersistenceObject]) {
        for hostObject in hostObjects {
            if let objectId = data.first(where: { $0.value == hostObject })?.key,
               let host = repository.getByKey(objectId) {
                hostObject.updateEntity(entity: host)
            }
        }
    }
}
