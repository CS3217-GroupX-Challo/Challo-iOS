//
//  MapItineraryPresenter.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import Combine
import GoogleMaps
import MapKit

class MapItineraryPresenter: NSObject, PresenterProtocol {
    var router: MapItineraryRouter?
    var interactor: MapItineraryInteractor!
    
    var locationManager: LocationManager
    var googleMapsView: GoogleMapsView?
    
    var isMarkerSelected: Bool = false
    var isRouteSelected: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var markers: [GMSMarker] = []
    
    override init() {
        let locationManager = LocationManager()
        self.locationManager = locationManager
        super.init()
        self.googleMapsView = GoogleMapsView(locationManager: self.locationManager,
                                             mapDelegate: self)
    }
    
    // Reset all buttons' selection state
    func resetButtonSelection(selectionStatus: Bool) {
        guard !selectionStatus else {
            return
        }
        
        isMarkerSelected = false
        isRouteSelected = false
    }
    
    func initializeBindings() {
        self.interactor.$mapMarkers.sink { [weak self] mapMarkers in
            guard let self = self else {
                return
            }
            self.markers = []
            for mapMarker in mapMarkers {
                let gmsMarker = self.initializeMarker(mapMarker: mapMarker)
                self.markers.append(gmsMarker)
            }
        }.store(in: &cancellables)
    }
}

// MARK: - Marker handling
extension MapItineraryPresenter {
    private func initializeMarker(mapMarker: MapMarker) -> GMSMarker {
        let gmsMarker = GMSMarker(position: mapMarker.position)
        gmsMarker.appearAnimation = .pop
        gmsMarker.icon = GMSMarker.markerImage(with: .systemPink)
        gmsMarker.isDraggable = true
        
        let title = mapMarker.comments ?? "Untitled"
        gmsMarker.title = title // Default title
        gmsMarker.map = googleMapsView?.mapView
        return gmsMarker
    }
    
    private func createAndStoreDefaultMapMarker(position: CLLocationCoordinate2D) {
        interactor.createAndStoreDefaultMapMarker(position: position)
    }
}

// TODO: Duplicated code, will abstract it to a new class
extension MapItineraryPresenter: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        var currentLatitude = position.target.latitude
        var currentLongitude = position.target.longitude
        var snapBack: Bool = false
        
        if currentLatitude < locationManager.minimumLatitude {
            currentLatitude = locationManager.minimumLatitude
            snapBack = true
        } else if currentLatitude > locationManager.maximumLatitude {
            currentLatitude = locationManager.maximumLatitude
            snapBack = true
        }
        
        if currentLongitude < locationManager.minimumLongitude {
            currentLongitude = locationManager.minimumLongitude
            snapBack = true
        } else if currentLongitude > locationManager.maximumLongitude {
            currentLongitude = locationManager.maximumLongitude
            snapBack = true
        }
        
        self.locationManager.location = CLLocation(latitude: currentLatitude,
                                                   longitude: currentLongitude)
        
        // if the current view out of bounds (ie over the himalayan regions, snap back to the bounds)
        if snapBack {
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude,
                                                               longitude: locationManager.longitude))
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if isMarkerSelected {
            self.createAndStoreDefaultMapMarker(position: coordinate)
        }
    }
}
