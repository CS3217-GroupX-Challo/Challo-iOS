//
//  CoreDataRepository.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData
import os

class CoreDataRepository<T: NSManagedObject>: RepositoryProtocol {
    typealias Entity = NSManagedObject
    
    typealias Key = NSManagedObjectID
    
    /// The NSManagedObjectContext instance to be used for performing the operations.
    private let managedObjectContext: NSManagedObjectContext
    
    private let logger = ChalloLogger.logger
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func getAll() -> [NSManagedObject] {
        let fetchRequest = Entity.fetchRequest()
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return fetchResults
            } else {
                return []
            }
        } catch {
            logger.log("\(error.localizedDescription)")
            return []
        }
    }
    
    func getByKey(_ key: NSManagedObjectID) -> NSManagedObject? {
        do {
            return try managedObjectContext.existingObject(with: key) 
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    // Creating a nsmanagedobject will use this context
    // hence just call managedObjectContext.save()
    @discardableResult
    func insert(_ entity: NSManagedObject, key: NSManagedObjectID?) -> NSManagedObjectID? {
        do {
            try managedObjectContext.save()
            return key
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    @discardableResult
    func deleteByKey(_ key: NSManagedObjectID) -> NSManagedObject? {
        guard let object = getByKey(key) else {
            return nil
        }
        managedObjectContext.delete(object)
        do {
            try managedObjectContext.save()
            return object
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil // object not deleted
        }
    }
    
    // default implementation
    // each managedobject needs to have its own properties updated
    @discardableResult
    func updateByKey(entity: NSManagedObject, key: NSManagedObjectID) -> NSManagedObject? {
        do {
            try managedObjectContext.save()
            return entity
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    // default implementation
    // each managedobject needs to have its own properties updated
    @discardableResult
    func upsert(entity: NSManagedObject, key: NSManagedObjectID) -> NSManagedObject {
        entity
    }
}
