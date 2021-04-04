//
//  MapItineraryRepository.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import CoreData
import Foundation

class MapItineraryRepository: MapItineraryRepositoryInterface {
    private var data: [NSManagedObjectID: MapItinerary]
    private var repository: CoreDataRepository<Itinerary>
    private var mapMarkerRepository: CoreDataRepository<Marker>
    private var mapRouteRepository: CoreDataRepository<Route>
    
    init(repository: CoreDataRepository<Itinerary>,
         mapMarkerRepository: CoreDataRepository<Marker>,
         mapRouteRepository: CoreDataRepository<Route>) {
        self.data = [NSManagedObjectID: MapItinerary]()
        self.repository = repository
        self.mapRouteRepository = mapRouteRepository
        self.mapMarkerRepository = mapMarkerRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: MapItinerary]()
        self.repository = CoreDataRepository<Itinerary>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.mapRouteRepository = CoreDataRepository<Route>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
        self.mapMarkerRepository = CoreDataRepository<Marker>(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
    }
    
    func getAllMapItineraries() -> [MapItinerary] {
        self.data = [NSManagedObjectID: MapItinerary]()
        let itineraries = repository.getAll()
        
        var mapItineraries: [MapItinerary] = []
        
        for itinerary in itineraries {
            if let mapItinerary = MapItineraryRepository
                .convertItineraryObjectToMapItinerary(itinerary: itinerary) {
                data[itinerary.objectID] = mapItinerary
                mapItineraries.append(mapItinerary)
            }
        }
        return mapItineraries
    }
    
    func saveMapItineraries(mapItineraries: [MapItinerary]) {
        let currentMapItineraries = getAllMapItineraries()
        
        let existingMapItineraries = mapItineraries.filter { mapItinerary in
            currentMapItineraries.contains(mapItinerary)
        }
        
        let newMapItineraries = mapItineraries.filter { mapItinerary in
            !existingMapItineraries.contains(mapItinerary)
        }
        
        saveNewMapItineraries(mapItineraries: newMapItineraries)
        updateMapItineraries(mapItineraries: existingMapItineraries)
        repository.commit()
    }
    
    private func saveNewMapItineraries(mapItineraries: [MapItinerary]) {
        for mapItinerary in mapItineraries {
            let itinerary = Itinerary(context: CoreDataContainer.managedObjectContext)
            itinerary.createdAt = mapItinerary.createdAt
            itinerary.title = mapItinerary.title
            itinerary.lastModified = mapItinerary.lastModified
            itinerary.id = mapItinerary.id.uuidString
            itinerary.markers = NSSet(array: getRelatedMapMarkers(mapMarkers: mapItinerary.markers))
            itinerary.routes = NSSet(array: getRelatedMapRoutes(mapRoutes: mapItinerary.routes))
        }
    }
    
    private func updateMapItineraries(mapItineraries: [MapItinerary]) {
        for mapItinerary in mapItineraries {
            if let objectId = data.first(where: { $0.value == mapItinerary })?.key,
               let itinerary = repository.getByKey(objectId) {
                itinerary.createdAt = mapItinerary.createdAt
                itinerary.title = mapItinerary.title
                itinerary.lastModified = mapItinerary.lastModified
                itinerary.id = mapItinerary.id.uuidString
                itinerary.markers = NSSet(array: getRelatedMapMarkers(mapMarkers: mapItinerary.markers))
                itinerary.routes = NSSet(array: getRelatedMapRoutes(mapRoutes: mapItinerary.routes))
            }
        }
    }
    
    private func getRelatedMapMarkers(mapMarkers: [MapMarker]) -> [Marker] {
        let markers = mapMarkerRepository.getAll()
        var filteredMarkers = [Marker]()
        
        for marker in markers {
            if mapMarkers.contains(where: { mapMarker in
                mapMarker.id.uuidString == marker.id
            }) {
                filteredMarkers.append(marker)
            }
        }
        
        return filteredMarkers
    }
    
    private func getRelatedMapRoutes(mapRoutes: [MapRoute]) -> [Route] {
        let routes = mapRouteRepository.getAll()
        var filteredRoutes = [Route]()
        
        for route in routes {
            if mapRoutes.contains(where: { mapRoute in
                mapRoute.id.uuidString == route.id
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
