//
//  MapItineraryRepository.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import CoreData

class MapItineraryRepository: MapItineraryRepositoryInterface {
    private var data: [NSManagedObjectID: ItineraryPersistenceObject]
    private var repository: CoreDataRepository<Itinerary>
    private var mapMarkerRepository: CoreDataRepository<Marker>
    private var mapRouteRepository: CoreDataRepository<Route>
    
    init(repository: CoreDataRepository<Itinerary>,
         mapMarkerRepository: CoreDataRepository<Marker>,
         mapRouteRepository: CoreDataRepository<Route>) {
        self.data = [NSManagedObjectID: ItineraryPersistenceObject]()
        self.repository = repository
        self.mapRouteRepository = mapRouteRepository
        self.mapMarkerRepository = mapMarkerRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: ItineraryPersistenceObject]()
        self.repository = CoreDataRepository<Itinerary>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.mapRouteRepository = CoreDataRepository<Route>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
        self.mapMarkerRepository = CoreDataRepository<Marker>(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
    }
    
    func getAllItineraries() -> [ItineraryPersistenceObject] {
        self.data = [NSManagedObjectID: ItineraryPersistenceObject]()
        let itineraries = repository.getAll()
        
        var itineraryObjects: [ItineraryPersistenceObject] = []
        
        for itinerary in itineraries {
            if let itineraryObject = ItineraryPersistenceObject(entity: itinerary) {
                data[itinerary.objectID] = itineraryObject
                itineraryObjects.append(itineraryObject)
            }
        }
        return itineraryObjects
    }
    
    func saveItineraries(itineraryObjects: [ItineraryPersistenceObject]) {
        let currentItineraryObjects = getAllItineraries()
        
        let existingItineraryObjects = itineraryObjects.filter { itineraryObject in
            currentItineraryObjects.contains(itineraryObject)
        }
        
        let newItineraryObjects = itineraryObjects.filter { itineraryObject in
            !existingItineraryObjects.contains(itineraryObject)
        }
        
        saveNewItineraries(itineraryObjects: newItineraryObjects)
        updateItineraries(itineraryObjects: existingItineraryObjects)
        repository.commit()
    }
    
    private func saveNewItineraries(itineraryObjects: [ItineraryPersistenceObject]) {
        for itineraryObject in itineraryObjects {
            if let itinerary = itineraryObject.convertToEntity() as? Itinerary {
                itinerary.markers = NSSet(array: getRelatedMarkers(markerObjects: itineraryObject.markers))
                itinerary.routes = NSSet(array: getRelatedRoutes(routeObjects: itineraryObject.routes))
            }
        }
    }
    
    private func updateItineraries(itineraryObjects: [ItineraryPersistenceObject]) {
        for itineraryObject in itineraryObjects {
            if let objectId = data.first(where: { $0.value == itineraryObject })?.key,
               let itinerary = repository.getByKey(objectId) {
                itineraryObject.updateEntity(entity: itinerary)
                itinerary.markers = NSSet(array: getRelatedMarkers(markerObjects: itineraryObject.markers))
                itinerary.routes = NSSet(array: getRelatedRoutes(routeObjects: itineraryObject.routes))
            }
        }
    }
    
    private func getRelatedMarkers(markerObjects: [MarkerPersistenceObject]) -> [Marker] {
        let markers = mapMarkerRepository.getAll()
        var filteredMarkers = [Marker]()
        
        for marker in markers {
            if markerObjects.contains(where: { markerObject in
                markerObject.id.uuidString == marker.id
            }) {
                filteredMarkers.append(marker)
            }
        }
        
        return filteredMarkers
    }
    
    private func getRelatedRoutes(routeObjects: [RoutePersistenceObject]) -> [Route] {
        let routes = mapRouteRepository.getAll()
        var filteredRoutes = [Route]()
        
        for route in routes {
            if routeObjects.contains(where: { routeObject in
                routeObject.id.uuidString == route.id
            }) {
                filteredRoutes.append(route)
            }
        }
        
        return filteredRoutes
    }
    
    static func convertItineraryObjectToMapItinerary(itinerary: Itinerary) -> MapItinerary? {
        guard let markerObjects = itinerary.markers,
              let routeObjects = itinerary.routes,
              let title = itinerary.title,
              let createdAt = itinerary.createdAt,
              let lastModified = itinerary.lastModified else {
            return nil
        }
        
        var mapMarkers: [MapMarker] = []
        var mapRoutes: [MapRoute] = []
        
        for markerObject in markerObjects {
            if let marker = markerObject as? Marker {
                mapMarkers.append(MapMarkerRepository.convertMarkerObjectToMapMarker(marker: marker))
            }
        }
        
        for routeObject in routeObjects {
            if let route = routeObject as? Route {
                if let mapRoute = MapRouteRepository.convertRouteObjectToMapRoute(route: route) {
                    mapRoutes.append(mapRoute)
                }
            }
        }
        
        return MapItinerary(id: UUID(uuidString: itinerary.id ?? "") ?? UUID(),
                            routes: mapRoutes,
                            markers: mapMarkers,
                            title: title,
                            createdAt: createdAt,
                            lastModified: lastModified)
    }
}
