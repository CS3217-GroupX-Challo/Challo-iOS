//
//  RouteRepository.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData
import Foundation

class MapRouteRepository: MapRouteRepositoryInterface {
    private var data: [NSManagedObjectID: MapRoute]
    private var repository: CoreDataRepository<Route>
    private var mapMarkerRepository: CoreDataRepository<Marker>
    
    init() {
        self.data = [NSManagedObjectID: MapRoute]()
        self.repository = CoreDataRepository<Route>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.mapMarkerRepository = CoreDataRepository<Marker>(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
    }
    
    func getAllRoutes() -> [MapRoute] {
        data = [NSManagedObjectID: MapRoute]()
        let routes = repository.getAll()
        var mapRoutes = [MapRoute]()
        
        for route in routes {
            if let mapRoute =
                MapRouteRepository.convertRouteObjectToMapRoute(route: route) {
                data[route.objectID] = mapRoute
                mapRoutes.append(mapRoute)
            }
        }
        
        return mapRoutes
    }
    
    func saveMapRoutes(mapRoutes: [MapRoute]) {
        let markers = mapMarkerRepository.getAll()
        
        for mapRoute in mapRoutes {
            let route = Route(context: CoreDataContainer.managedObjectContext)
            route.comments = mapRoute.comments
            route.date = mapRoute.date
            route.id = mapRoute.id.uuidString
            
            for marker in markers {
                if marker.id == mapRoute.start.id.uuidString {
                    route.start = marker
                    marker.routeStart = route
                } else if marker.id == mapRoute.end.id.uuidString {
                    route.end = marker
                    marker.routeEnd = route
                }
            }
            
            repository.insert(route, key: route.objectID)
        }
    }
    
    static func convertRouteObjectToMapRoute(route: Route) -> MapRoute? {
        guard let start = route.start,
              let end = route.end else {
            return nil
        }
        
        return MapRoute(id: UUID(uuidString: route.id ?? "") ?? UUID(),
                        start: MapMarkerRepository.convertMarkerObjectToMapMarker(marker: start),
                        end: MapMarkerRepository.convertMarkerObjectToMapMarker(marker: end),
                        date: route.date,
                        comments: route.comments)
    }
}
