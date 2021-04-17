//
//  RouteRepository.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData

class MapRouteRepository: MapRouteRepositoryInterface {
    private var data: [NSManagedObjectID: RoutePersistenceObject]
    private var repository: CoreDataRepository<Route>
    private var mapMarkerRepository: CoreDataRepository<Marker>
    
    init(repository: CoreDataRepository<Route>, mapMarkerRepository: CoreDataRepository<Marker>) {
        self.data = [NSManagedObjectID: RoutePersistenceObject]()
        self.repository = repository
        self.mapMarkerRepository = mapMarkerRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: RoutePersistenceObject]()
        self.repository = CoreDataRepository<Route>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.mapMarkerRepository = CoreDataRepository<Marker>(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
    }
    
    func getAllRoutes() -> [RoutePersistenceObject] {
        data = [NSManagedObjectID: RoutePersistenceObject]()
        let routes = repository.getAll()
        var routeObjects = [RoutePersistenceObject]()
        
        for route in routes {
            if let routeObject =
                RoutePersistenceObject(entity: route) {
                data[route.objectID] = routeObject
                routeObjects.append(routeObject)
            }
        }
        
        return routeObjects
    }
    
    func saveRoutes(routeObjects: [RoutePersistenceObject]) {
        let routes = getAllRoutes()
        
        let existingRouteObjects = routeObjects.filter { routeObject in
            routes.contains(routeObject)
        }
        
        let toSaveRouteObjects = routeObjects.filter { routeObject in
            !existingRouteObjects.contains(routeObject)
        }
        
        updateRoutes(routeObjects: existingRouteObjects)
        saveNewRoutes(routeObjects: toSaveRouteObjects)
        repository.commit()
    }
    
    private func updateRoutes(routeObjects: [RoutePersistenceObject]) {
        for routeObject in routeObjects {
            if let objectId = data.first(where: { $0.value == routeObject })?.key,
               let managedObject = repository.getByKey(objectId) {
                routeObject.updateEntity(entity: managedObject)
            }
        }
    }
    
    private func saveNewRoutes(routeObjects: [RoutePersistenceObject]) {
        let markers = mapMarkerRepository.getAll()
        
        for routeObject in routeObjects {
            let managedObject = routeObject.convertToEntity()
            
            if let route = managedObject as? Route {
                for marker in markers {
                    if marker.id == routeObject.start.id.uuidString {
                        route.start = marker
                        marker.routeStart = route
                    } else if marker.id == routeObject.end.id.uuidString {
                        route.end = marker
                        marker.routeEnd = route
                    }
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
