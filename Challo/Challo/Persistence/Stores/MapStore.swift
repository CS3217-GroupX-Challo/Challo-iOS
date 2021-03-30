//
//  MapMarkerStore.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

class MapStore {
    private var mapMarkerRepository: MapMarkerRepositoryInterface
    private var mapRouteRepository: MapRouteRepositoryInterface
    
    init(mapMarkerRepository: MapMarkerRepositoryInterface,
         mapRouteRepository: MapRouteRepositoryInterface) {
        self.mapMarkerRepository = mapMarkerRepository
        self.mapRouteRepository = mapRouteRepository
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
}
