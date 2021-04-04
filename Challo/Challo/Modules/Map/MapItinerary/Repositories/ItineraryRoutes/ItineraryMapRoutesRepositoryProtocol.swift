//
//  ItineraryRoutesRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import Foundation

protocol ItineraryMapRoutesRepositoryProtocol {
    func addRoute(route: MapRoute)
    func getRoutes() -> [MapRoute]
}
