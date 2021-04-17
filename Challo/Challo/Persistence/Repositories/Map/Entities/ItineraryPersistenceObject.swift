//
//  ItineraryPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 11/4/21.
//

import CoreData
import Foundation

struct ItineraryPersistenceObject {
    var id: UUID
    var routes: [RoutePersistenceObject]
    var markers: [MarkerPersistenceObject]
    var title: String
    var createdAt: Date
    var lastModified: Date
}

extension ItineraryPersistenceObject: CoreDataPersistenceObject {
    init?(entity: NSManagedObject) {
        guard let itinerary = entity as? Itinerary,
              let routes = itinerary.routes,
              let markers = itinerary.markers else {
            return nil
        }
        
        self.id = UUID(uuidString: itinerary.id ?? "") ?? UUID()
        self.title = itinerary.title ?? ""
        self.createdAt = itinerary.createdAt ?? Date()
        self.lastModified = itinerary.lastModified ?? Date()
        
        var routePersistenceObjects: [RoutePersistenceObject] = []
        for route in routes {
            if let routeObject = route as? Route,
               let routePersistenceObject = RoutePersistenceObject(entity: routeObject) {
                routePersistenceObjects.append(routePersistenceObject)
            }
        }
        self.routes = routePersistenceObjects
        
        var markerPersistenceObjects: [MarkerPersistenceObject] = []
        for marker in markers {
            if let markerObject = marker as? Marker,
               let markerPersistenceObject = MarkerPersistenceObject(entity: markerObject) {
                markerPersistenceObjects.append(markerPersistenceObject)
            }
        }
        self.markers = markerPersistenceObjects
    }
    
    func convertToEntity() -> NSManagedObject {
        let itinerary = Itinerary(context: CoreDataContainer.managedObjectContext)
        itinerary.createdAt = createdAt
        itinerary.title = title
        itinerary.lastModified = lastModified
        itinerary.id = id.uuidString
        return itinerary
    }
    
    func updateEntity(entity: NSManagedObject) {
        guard let itinerary = entity as? Itinerary else {
            return
        }
        itinerary.createdAt = createdAt
        itinerary.title = title
        itinerary.lastModified = lastModified
        itinerary.id = id.uuidString
    }
}

// MARK: - Equtable
extension ItineraryPersistenceObject: Equatable {
    static func == (lhs: ItineraryPersistenceObject, rhs: ItineraryPersistenceObject) -> Bool {
        lhs.id == rhs.id
    }
}
