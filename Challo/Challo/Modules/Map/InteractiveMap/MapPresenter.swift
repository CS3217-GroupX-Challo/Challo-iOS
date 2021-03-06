//
//  MapPresenter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import Combine
import GoogleMaps
import MapKit
import SwiftUI

@objc
class MapPresenter: NSObject, PresenterProtocol {
    var router: MapRouter?
    var interactor: MapInteractor!
    
    var locationManager: LocationManager
    
    var googleMapsView: GoogleMapsView?
    
    private var markers: [GMSMarker] = []
    
    @Published var foundPlaces: [Place] = [] {
        didSet {
            // TODO add markers
            updateMapWithMarkers()
        }
    }
    
    @Published var searchQuery: String = ""
    
    @Published var itineraries: [MapItinerary] = []
    
    static var test = MapItinerary(id: UUID(),
                                   routes: [],
                                   markers: [],
                                   title: "Dream grad trip!!",
                                   createdAt: Date(),
                                   lastModified: Date())
    
    override init() {
        let locationManager = LocationManager()
        self.locationManager = locationManager
        super.init()
        let googleMapsView = GoogleMapsView(locationManager: self.locationManager,
                                            mapDelegate: self)
        self.googleMapsView = googleMapsView
    }
    
    func findPlaces() {
        interactor.getPlaces(with: searchQuery)
    }

    func refreshItineraries() {
        self.itineraries = interactor.getMapItineraries()
    }
    
    private func updateMapWithMarkers() {
        guard let gmsView = googleMapsView?.mapView else {
            return
        }
        
        gmsView.clear()
        markers = []
        
        for place in self.foundPlaces {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.latitude,
                                                     longitude: place.longitude)
            marker.title = place.name
            marker.appearAnimation = .pop
            marker.icon = GMSMarker.markerImage(with: .black)
            self.markers.append(marker) // so that they are not cleared up by ARC
        }
        
        for marker in markers {
            marker.map = gmsView
        }
    }
}

extension MapPresenter: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        locationManager.updateCurrentCoordinates(newLongitude: position.target.longitude,
                                                 newLatitude: position.target.latitude,
                                                 mapView: mapView)
    }
}

// MARK: Routing to and fro itinerary creation/edit
extension MapPresenter {

    func getNewItineraryPage() -> AnyView? {
        router?.getNewItineraryPage()
    }

    func getItineraryPage(for itinerary: MapItinerary) -> AnyView? {
        router?.getItineraryPage(for: itinerary)
    }

    func getMapPage() -> AnyView? {
        router?.mapView
    }
}
