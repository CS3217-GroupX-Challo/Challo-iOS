//
//  RouteRepositoryInterface.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import Foundation

protocol MapRouteRepositoryInterface {
    func getAllRoutes() -> [MapRoute]
    func saveMapRoutes(mapRoutes: [MapRoute])
}
