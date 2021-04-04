//
//  MockRouteCoreDataRepository.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import Foundation

@testable import Challo

class MockMapRouteCoreDataRepository: CoreDataRepository<Route> {
    typealias mockRepo = MockMapRouteCoreDataRepository
    
    static var id = UUID()
    static var date = Date()
    
    static var route1: Route {
        let route = Route(context: CoreDataContainer.managedObjectContext)
        route.id = id.uuidString
        route.comments = "hi"
        route.date = date
        route.start = MockMapMarkerCoreDataRepository.marker1
        route.end = MockMapMarkerCoreDataRepository.marker2
        return route
    }
    
    static var mapRoute1: MapRoute {
        MapRoute(id: id,
                 start: MockMapMarkerCoreDataRepository.mapMarker1,
                 end: MockMapMarkerCoreDataRepository.mapMarker2,
                 date: Date(),
                 comments: "hi")
    }
    
    var data = [Route]()
    
    override func getAll() -> [Route] {
        data
    }
    
    override func commit() {
    }
}
