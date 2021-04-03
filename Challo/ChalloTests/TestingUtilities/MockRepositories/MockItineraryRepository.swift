//
//  MockItineraryRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import Foundation

class MockItineraryRepository: MapItineraryRepositoryInterface {

    static let itineraryOne = MapItinerary(id: UUID(),
                                           routes: [],
                                           markers: [MockMarkerRepository.markerOne, MockMarkerRepository.markerTwo],
                                           title: "Test itinerary One",
                                           createdAt: Date.construct(with: "2021-05-15T15:10:45.178Z") ?? Date(),
                                           lastModified: Date.construct(with: "2021-05-15T15:10:45.178Z") ?? Date())
    
    static let itineraryTwo = MapItinerary(id: UUID(),
                                           routes: [MockRouteRepository.routeTwo],
                                           markers: [MockMarkerRepository.markerTwo, MockMarkerRepository.markerThree],
                                           title: "Test itinerary Two",
                                           createdAt: Date.construct(with: "2021-05-16T15:10:45.178Z") ?? Date(),
                                           lastModified: Date.construct(with: "2021-05-16T15:10:45.178Z") ?? Date())

    var allItineraries = [itineraryOne, itineraryTwo]
    
    func getAllMapItineraries() -> [MapItinerary] {
        allItineraries
    }
    
    func saveMapItineraries(mapItineraries: [MapItinerary]) {
        mapItineraries.forEach {
            allItineraries.append($0)
        }
    }
}
