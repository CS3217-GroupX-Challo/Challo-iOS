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

    func getAllRoutes() -> [RoutePersistenceObject] {
        allRoutes.map { route in
            let convertor = MapModelConvertor()
            return convertor.convertMapRouteToRoutePersistenceObject(mapRoute: route)
        }
    }
    
    func saveRoutes(routeObjects: [RoutePersistenceObject]) {
    }
}
