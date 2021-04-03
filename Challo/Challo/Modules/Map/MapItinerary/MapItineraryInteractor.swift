//
//  MapItineraryInteractor.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import Combine
import Foundation
import MapKit

class MapItineraryInteractor: InteractorProtocol, ObservableObject {
    var presenter: MapItineraryPresenter!
    
    private var mapStore: MapStore
    private var individualItineraryRepository: IndividualItineraryRepository
    private var mapItinerary: MapItinerary
    
    @Published var mapMarkers: [MapMarker] = []
    @Published var mapRoutes: [MapRoute] = []
    
    init(mapItinerary: MapItinerary, mapStore: MapStore) {
        self.mapMarkers = mapItinerary.markers
        self.mapRoutes = mapItinerary.routes
        self.mapStore = mapStore
        self.mapItinerary = mapItinerary
        self.individualItineraryRepository
            = IndividualItineraryRepository(mapMarkers: mapItinerary.markers,
                                            mapRoutes: mapItinerary.routes)
    }
    
    convenience init(mapStore: MapStore) {
        let mapItinerary = MapItinerary(id: UUID(),
                                        routes: [],
                                        markers: [],
                                        title: "",
                                        createdAt: Date(),
                                        lastModified: Date())
        self.init(mapItinerary: mapItinerary,
                  mapStore: mapStore)
    }
    
    func createAndStoreDefaultMapMarker(position: CLLocationCoordinate2D) {
        individualItineraryRepository.createAndStoreDefaultMapMarker(at: position)
    }
    
    func getMarkerPresent(at position: CLLocationCoordinate2D) -> MapMarker? {
        individualItineraryRepository.getMapMarker(at: position)
    }
    
    func deleteMarker(at position: CLLocationCoordinate2D) {
        individualItineraryRepository.deleteMapMarker(at: position)
    }
    
    func addMarker(mapMarker: MapMarker) {
        individualItineraryRepository.addMapMarker(mapMarker: mapMarker)
    }
}
