//
//  MockMapMarkerCoreDataRepository.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import CoreData
import Foundation
import MapKit

@testable import Challo

// This mock class has no context and does not commit transactions
class MockMapMarkerCoreDataRepository: CoreDataRepository<Marker> {
    typealias repository = MockMapMarkerCoreDataRepository

    static var id = UUID()
    static var date = Date()
    
    static var marker1: Marker {
        let marker = Marker(context: CoreDataContainer.managedObjectContext)
        marker.id = id.uuidString
        marker.comments = "hi"
        marker.date = date
        marker.latitude = 10
        marker.longitude = 10
        return marker
    }
    
    static var marker2: Marker {
        let marker = Marker(context: CoreDataContainer.managedObjectContext)
        marker.id = id.uuidString
        marker.comments = "good bye"
        marker.date = date
        marker.latitude = 20
        marker.longitude = 20
        return marker
    }
    
    static var mapMarker1: MapMarker {
        MapMarker(id: id,
                  position: CLLocationCoordinate2D(latitude: 10,
                                                   longitude: 10),
                  date: date,
                  comments: "hi")
    }
    
    static var mapMarker2: MapMarker {
        MapMarker(id: id,
                  position: CLLocationCoordinate2D(latitude: 20,
                                                   longitude: 20),
                  date: date,
                  comments: "hi")
    }
    
    var data = [NSManagedObjectID: Marker]()
    
    override func getAll() -> [Marker] {
        data.values.compactMap({ $0 })
    }
    
    override func getByKey(_ key: NSManagedObjectID) -> Marker? {
        data[key]
    }
    
    override func insert(_ entity: Marker, key: NSManagedObjectID?) -> NSManagedObjectID? {
        guard let id = key else {
            return nil
        }
        
        return id
    }
    
    override func commit() {
    }
}
