//
//  ItineraryRoutesRepository.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import Foundation

class ItineraryMapRoutesRepository: Repository<UUID, MapRoute>, ItineraryMapRoutesRepositoryProtocol {
    func addRoute(route: MapRoute) {
        insert(route, key: route.id)
    }
    
    func getRoutes() -> [MapRoute] {
        getAll()
    }
}
