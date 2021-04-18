//
//  CoreDataContainer.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData

/// Contains the managedContext for Core Data
class CoreDataContainer {
    static var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Challo")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
    static var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
