//
//  MockMapItineraryCoreDataRepository.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import Foundation

@testable import Challo

class MockMapItineraryCoreDataRepository: CoreDataRepository<Itinerary> {
    
    static var id = UUID()
    static var date = Date()
    
    static var mapItinerary: MapItinerary {
        MapItinerary(id: id,
                     routes: [],
                     markers: [],
                     title: "HI",
                     createdAt: date,
                     lastModified: date)
    }
    
    static var itinerary: Itinerary {
        let itinerary = Itinerary(context: CoreDataContainer.managedObjectContext)
        itinerary.id = id.uuidString
        itinerary.createdAt = date
        itinerary.lastModified = date
        itinerary.markers = NSSet()
        itinerary.routes = NSSet()
        itinerary.title = "hi"
        return itinerary
    }
    
    var data = [Itinerary]()
    
    override func getAll() -> [Itinerary] {
        data
    }
    
    override func commit() {
    }
}
