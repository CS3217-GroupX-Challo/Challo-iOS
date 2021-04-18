//
//  CoreDataPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 10/4/21.
//

import CoreData

/// Protocol for conversion between Persistence to NSManagedObject
protocol CoreDataPersistenceObject: PersistenceObjectProtocol where Entity: NSManagedObject {
}
