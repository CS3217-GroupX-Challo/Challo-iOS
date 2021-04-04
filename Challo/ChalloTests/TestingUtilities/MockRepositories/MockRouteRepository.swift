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
    
    static func createEmptyRepo() -> MapRouteRepositoryInterface {
        let repo = MockRouteRepository()
        repo.allRoutes = []
        return repo
    }
    
    var allRoutes = [MapTestConstants.routeOne, MapTestConstants.routeTwo]

    func getAllRoutes() -> [MapRoute] {
        allRoutes
    }
    
    func saveMapRoutes(mapRoutes: [MapRoute]) {
        mapRoutes.forEach {
            allRoutes.append($0)
        }
    }
}
