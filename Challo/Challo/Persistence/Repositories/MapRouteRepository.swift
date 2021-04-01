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
        let routes = getAllRoutes()
        
        let existingMapRoutes = mapRoutes.filter { mapRoute in
            routes.contains(mapRoute)
        }
        
        let toSaveMapRoutes = mapRoutes.filter { mapRoute in
            !existingMapRoutes.contains(mapRoute)
        }
        
        updateMapRoutes(mapRoutes: existingMapRoutes)
        saveNewMapRoutes(mapRoutes: toSaveMapRoutes)
        repository.commit()
    }
    
    private func updateMapRoutes(mapRoutes: [MapRoute]) {
        for mapRoute in mapRoutes {
            if let objectId = data.first(where: { $0.value == mapRoute })?.key,
               let managedObject = repository.getByKey(objectId) {
                managedObject.comments = mapRoute.comments
                managedObject.date = mapRoute.date
                managedObject.id = mapRoute.id.uuidString
            }
        }
    }
    
    private func saveNewMapRoutes(mapRoutes: [MapRoute]) {
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
