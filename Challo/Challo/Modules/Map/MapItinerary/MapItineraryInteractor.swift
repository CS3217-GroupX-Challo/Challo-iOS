//
//  MapItineraryInteractor.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import Combine
import MapKit

class MapItineraryInteractor: InteractorProtocol, ObservableObject {
    var presenter: MapItineraryPresenter!
    
    @Published var mapMarkers: [CLLocationCoordinate2D: MapMarker]
    @Published var mapRoutes: [MapRoute]
    
    init(mapMarkers: [CLLocationCoordinate2D: MapMarker], mapRoutes: [MapRoute]) {
        self.mapMarkers = mapMarkers
        self.mapRoutes = mapRoutes
    }
    
    convenience init() {
        self.init(mapMarkers: [CLLocationCoordinate2D: MapMarker](), mapRoutes: [])
    }
    
    func createAndStoreDefaultMapMarker(position: CLLocationCoordinate2D) {
        let mapMarker = MapMarker(id: UUID(),
                                  position: position,
                                  date: nil,
                                  comments: nil)
        mapMarkers[position] = mapMarker
    }
    
    func getMarkerPresent(at position: CLLocationCoordinate2D) -> MapMarker? {
        mapMarkers[position]
    }
    
    func deleteMarker(at position: CLLocationCoordinate2D) {
        mapMarkers.removeValue(forKey: position)
    }
    
    func addMarker(at position: CLLocationCoordinate2D, mapMarker: MapMarker) {
        mapMarkers[position] = mapMarker
    }
}
