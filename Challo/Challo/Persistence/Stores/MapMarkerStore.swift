//
//  MapMarkerStore.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

class MapMarkerStore {
    private var repository: MapMarkerRepositoryInterface
    
    init(repository: MapMarkerRepositoryInterface) {
        self.repository = repository
    }
    
    func getAllMapMarkers() -> [MapMarker] {
        repository.getAllMapMarkers()
    }
    
    func saveMapMarkers(mapMarkers: [MapMarker]) {
        repository.saveMapMarkers(mapMarkers: mapMarkers)
    }
}
