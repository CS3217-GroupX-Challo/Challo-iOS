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
    
    init(mapMarkerRepository: MapMarkerRepositoryInterface,
         mapRouteRepository: MapRouteRepositoryInterface,
         mapItineraryRepository: MapItineraryRepositoryInterface) {
        self.mapMarkerRepository = mapMarkerRepository
        self.mapRouteRepository = mapRouteRepository
        self.mapItineraryRepository = mapItineraryRepository
    }

    func getAllMapMarkers() -> [MapMarker] {
        mapMarkerRepository.getAllMapMarkers()
    }
    
    func saveMapMarkers(mapMarkers: [MapMarker]) {
        mapMarkerRepository.saveMapMarkers(mapMarkers: mapMarkers)
    }
    
    func getAllMapRoutes() -> [MapRoute] {
        mapRouteRepository.getAllRoutes()
    }
    
    func saveMapRoutes(mapRoutes: [MapRoute]) {
        mapRouteRepository.saveMapRoutes(mapRoutes: mapRoutes)
    }
    
    func saveMapItineraries(mapItineraries: [MapItinerary]) {
        mapItineraryRepository.saveMapItineraries(mapItineraries: mapItineraries)
    }
    
    func getAllMapItineraries() -> [MapItinerary] {
        mapItineraryRepository.getAllMapItineraries()
    }
}
