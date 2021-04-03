//
//  MockRouteRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import MapKit
import Foundation

class MockRouteRepository: MapRouteRepositoryInterface {
    
    static let routeOne = MapRoute(id: UUID(),
                                   start: MockMarkerRepository.markerOne,
                                   end: MockMarkerRepository.markerTwo,
                                   date: Date.construct(with: "2021-03-12T15:17:14.178Z"),
                                   comments: "This is route one!")
    
    static let routeTwo = MapRoute(id: UUID(),
                                   start: MockMarkerRepository.markerTwo,
                                   end: MockMarkerRepository.markerThree,
                                   date: Date.construct(with: "2021-03-13T15:10:45.178Z"),
                                   comments: "This is route two!")
    
    var allRoutes = [routeOne, routeTwo]

    func getAllRoutes() -> [MapRoute] {
        allRoutes
    }
    
    func saveMapRoutes(mapRoutes: [MapRoute]) {
        mapRoutes.forEach {
            allRoutes.append($0)
        }
    }
}
