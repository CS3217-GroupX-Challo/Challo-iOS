//
//  RoutePersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import CoreData
import Foundation

struct RoutePersistenceObject {
    var id: UUID
    var start: MarkerPersistenceObject
    var end: MarkerPersistenceObject
    var date: Date?
    var comments: String?
}

extension RoutePersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let route = persistenceObject as? Route,
              let start = route.start,
              let end = route.end else {
            return nil
        }
        
        guard let markerStart = MarkerPersistenceObject(persistenceObject: start),
              let markerEnd = MarkerPersistenceObject(persistenceObject: end) else {
            return nil
        }
        
        self.id = UUID(uuidString: route.id ?? "") ?? UUID()
        self.date = route.date
        self.comments = route.comments
        self.start = markerStart
        self.end = markerEnd
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let route = Route(context: CoreDataContainer.managedObjectContext)
        route.comments = comments
        route.date = date
        route.id = id.uuidString
        return route
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let route = persistenceObject as? Route else {
            return
        }
        
        route.comments = comments
        route.date = date
        route.id = id.uuidString
    }
}

// MARK: - Equtable
extension RoutePersistenceObject: Equatable {
    static func == (lhs: RoutePersistenceObject, rhs: RoutePersistenceObject) -> Bool {
        lhs.id == rhs.id
    }
}
