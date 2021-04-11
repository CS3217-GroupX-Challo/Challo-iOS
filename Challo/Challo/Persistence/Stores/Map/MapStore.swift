//
//  MapMarkerStore.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

class MapStore {
    private var mapMarkerRepository: MapMarkerRepositoryInterface
    private var mapRouteRepository: MapRouteRepositoryInterface
    private var mapItineraryRepository: MapItineraryRepositoryInterface
    private let convertor = MapModelConvertor()
    
    init(mapMarkerRepository: MapMarkerRepositoryInterface,
         mapRouteRepository: MapRouteRepositoryInterface,
         mapItineraryRepository: MapItineraryRepositoryInterface) {
        self.mapMarkerRepository = mapMarkerRepository
        self.mapRouteRepository = mapRouteRepository
        self.mapItineraryRepository = mapItineraryRepository
    }

    func getAllMapMarkers() -> [MapMarker] {
        let markerObjects = mapMarkerRepository.getAllMarkers()
        return markerObjects.map { markerObject in
            convertor.convertMarkerPersistenceObjectToMapMarker(markerObject: markerObject)
        }
    }
    
    func saveMapMarkers(mapMarkers: [MapMarker]) {
        let markerObjects = mapMarkers.map { mapMarker in
            convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker: mapMarker)
        }
        mapMarkerRepository.saveMarkers(markerObjects: markerObjects)
    }
    
    func getAllMapRoutes() -> [MapRoute] {
        let routeObjects = mapRouteRepository.getAllRoutes()
        return routeObjects.map { routeObject in
            convertor.convertRoutePersistenceObjectToMapRoute(routeObject: routeObject)
        }
    }
    
    func saveMapRoutes(mapRoutes: [MapRoute]) {
        let routeObjects = mapRoutes.map { mapRoute in
            convertor.convertMapRouteToRoutePersistenceObject(mapRoute: mapRoute)
        }
        mapRouteRepository.saveRoutes(routeObjects: routeObjects)
    }
    
    func saveMapItineraries(mapItineraries: [MapItinerary]) {
        let itineraryObjects = mapItineraries.map { mapItinerary in
            convertor.convertMapItineraryToItineraryPersistenceObject(mapIitnerary: mapItinerary)
        }
        mapItineraryRepository.saveItineraries(itineraryObjects: itineraryObjects)
    }
    
    func getAllMapItineraries() -> [MapItinerary] {
        let itineraryObjects = mapItineraryRepository.getAllItineraries()
        return itineraryObjects.map { itineraryObject in
            convertor.convertItineraryPersistenceObjectToMapItinerary(itineraryObject: itineraryObject)
        }
    }
}
