//
//  MarkerPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 10/4/21.
//

import CoreData
import Foundation
import MapKit

/// A structure to store marker properties to be saved in persistence
struct MarkerPersistenceObject {
    var id: UUID
    var position: CLLocationCoordinate2D
    var date: Date?
    var comments: String?
}

// MARK: - CoreDataPersistenceObject
extension MarkerPersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let marker = persistenceObject as? Marker else {
            return nil
        }
        
        self.id = UUID(uuidString: marker.id ?? "") ?? UUID()
        self.position = CLLocationCoordinate2D(latitude: marker.latitude,
                                               longitude: marker.longitude)
        self.comments = marker.comments
        self.date = marker.date
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let marker = Marker(context: CoreDataContainer.managedObjectContext)
        marker.id = id.uuidString
        marker.comments = comments
        marker.longitude = position.longitude
        marker.latitude = position.latitude
        marker.date = date
        return marker
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let marker = persistenceObject as? Marker else {
            return
        }
        
        marker.setValue(id.uuidString, forKey: "id")
        marker.setValue(position.latitude, forKey: "latitude")
        marker.setValue(position.longitude, forKey: "longitude")
        marker.setValue(date, forKey: "date")
        marker.setValue(comments, forKey: "comments")
    }
}

// MARK: - Equtable
extension MarkerPersistenceObject: Equatable {
    static func == (lhs: MarkerPersistenceObject, rhs: MarkerPersistenceObject) -> Bool {
        lhs.id == rhs.id
    }
}
