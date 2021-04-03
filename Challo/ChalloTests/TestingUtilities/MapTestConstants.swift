//
//  MapTestConstants.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import MapKit
import Foundation

struct MapTestConstants {

    static let markerOne = MapMarker(id: UUID(),
                                     position: CLLocationCoordinate2D(latitude: 10, longitude: 10),
                                     date: Date.construct(with: "2021-04-03T15:17:14.178Z"),
                                     comments: "Marker one!")
    
    static let markerTwo = MapMarker(id: UUID(),
                                     position: CLLocationCoordinate2D(latitude: 20, longitude: 111),
                                     date: Date.construct(with: "2021-03-12T15:17:14.178Z"),
                                     comments: "Marker two!")
    
    static let markerThree = MapMarker(id: UUID(),
                                       position: CLLocationCoordinate2D(latitude: 11, longitude: 73),
                                       date: Date.construct(with: "2021-01-12T15:11:14.178Z"),
                                       comments: nil)

    static let routeOne = MapRoute(id: UUID(),
                                   start: markerOne,
                                   end: markerTwo,
                                   date: Date.construct(with: "2021-03-12T15:17:14.178Z"),
                                   comments: "This is route one!")
    
    static let routeTwo = MapRoute(id: UUID(),
                                   start: markerTwo,
                                   end: markerThree,
                                   date: Date.construct(with: "2021-03-13T15:10:45.178Z"),
                                   comments: "This is route two!")

    static let itineraryOne = MapItinerary(id: UUID(),
                                           routes: [],
                                           markers: [markerOne, markerTwo],
                                           title: "Test itinerary One",
                                           createdAt: Date.construct(with: "2021-05-15T15:10:45.178Z") ?? Date(),
                                           lastModified: Date.construct(with: "2021-05-15T15:10:45.178Z") ?? Date())
    
    static let itineraryTwo = MapItinerary(id: UUID(),
                                           routes: [routeTwo],
                                           markers: [markerTwo, markerThree],
                                           title: "Test itinerary Two",
                                           createdAt: Date.construct(with: "2021-05-16T15:10:45.178Z") ?? Date(),
                                           lastModified: Date.construct(with: "2021-05-16T15:10:45.178Z") ?? Date())
}
