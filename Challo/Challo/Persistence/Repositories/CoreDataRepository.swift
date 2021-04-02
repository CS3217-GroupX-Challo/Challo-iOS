//
//  CoreDataRepository.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData
import os

class CoreDataRepository<T: NSManagedObject>: RepositoryProtocol {
    typealias Entity = T
    
    typealias Key = NSManagedObjectID
    
    /// The NSManagedObjectContext instance to be used for performing the operations.
    private let managedObjectContext: NSManagedObjectContext
    
    private let logger = ChalloLogger.logger
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func getAll() -> [T] {
        let fetchRequest = T.fetchRequest()
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [T] {
                return fetchResults
            } else {
                return []
            }
        } catch {
            logger.log("\(error.localizedDescription)")
            return []
        }
    }
    
    func getByKey(_ key: NSManagedObjectID) -> T? {
        do {
            return try managedObjectContext.existingObject(with: key) as? T
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    @discardableResult
    func insert(_ entity: T, key: NSManagedObjectID) -> NSManagedObjectID? {
        do {
            try managedObjectContext.save()
            return key
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    @discardableResult
    func deleteByKey(_ key: NSManagedObjectID) -> T? {
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
    
    @discardableResult
    func updateByKey(entity: T, key: NSManagedObjectID) -> T? {
        do {
            try managedObjectContext.save()
            return entity
        } catch {
            logger.log("\(error.localizedDescription)")
            return nil
        }
    }
    
    func upsert(entity: T, key: NSManagedObjectID) -> T {
        entity
    }
}

extension CoreDataRepository {
    func commit() {
        do {
            try managedObjectContext.save()
        } catch {
            logger.log("\(error.localizedDescription)")
        }
    }
}
