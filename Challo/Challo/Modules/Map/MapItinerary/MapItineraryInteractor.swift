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

    func createAndStoreDefaultMapMarker(position: CLLocationCoordinate2D) {
        individualItineraryRepository.createAndStoreDefaultMapMarker(at: position)
        self.mapMarkers = individualItineraryRepository.getAllMapMarkers()
    }
    
    func getMarkerPresent(at position: CLLocationCoordinate2D) -> MapMarker? {
        individualItineraryRepository.getMapMarker(at: position)
    }
    
    func deleteMarker(at position: CLLocationCoordinate2D) {
        individualItineraryRepository.deleteMapMarker(at: position)
        self.mapMarkers = individualItineraryRepository.getAllMapMarkers()
    }
    
    func addMarker(mapMarker: MapMarker) {
        individualItineraryRepository.addMapMarker(mapMarker: mapMarker)
        self.mapMarkers = individualItineraryRepository.getAllMapMarkers()
    }

    func editMarker(at position: CLLocationCoordinate2D, edited: MapMarker) {
        individualItineraryRepository.deleteMapMarker(at: position)
        individualItineraryRepository.addMapMarker(mapMarker: edited)
        self.mapMarkers = individualItineraryRepository.getAllMapMarkers()
    }
    
    func saveItinerary(title: String) {
        updateItineraryBeforeSaving(title: title)
        mapStore.saveMapMarkers(mapMarkers: mapItinerary.markers)
        mapStore.saveMapRoutes(mapRoutes: mapItinerary.routes)
        mapStore.saveMapItineraries(mapItineraries: [mapItinerary])
    }
    
    private func updateItineraryBeforeSaving(title: String) {
        mapItinerary.title = title
        mapItinerary.markers = mapMarkers
        mapItinerary.routes = mapRoutes
        mapItinerary.lastModified = Date()
    }
}
