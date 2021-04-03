//
//  MockMarkerRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import MapKit
import Foundation

class MockMarkerRepository: MapMarkerRepositoryInterface {

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

    var allMarkers = [markerOne, markerTwo, markerThree]

    func getAllMapMarkers() -> [MapMarker] {
        allMarkers
    }

    func saveMapMarkers(mapMarkers: [MapMarker]) {
        mapMarkers.forEach {
            allMarkers.append($0)
        }
    }
}
