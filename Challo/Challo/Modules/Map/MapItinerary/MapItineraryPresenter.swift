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
    
    @Published var isMarkerSelected: Bool = false
    @Published var isRouteSelected: Bool = false
    @Published var isDeleteSelected: Bool = false
    @Published var isSaveSelected: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var movedMarkerInitialPosition: CLLocationCoordinate2D?
    
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
        isDeleteSelected = false
        isSaveSelected = false
    }
    
    func initializeBindings() {
        self.interactor.$mapMarkers.sink { [weak self] mapMarkers in
            guard let self = self else {
                return
            }
            self.markers = []
            self.googleMapsView?.mapView.clear() // clear all google maps markers
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
        if isSaveSelected {
            isSaveSelected.toggle()
            return
        }
        
        if isMarkerSelected {
            self.createAndStoreDefaultMapMarker(position: coordinate)
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if isDeleteSelected {
            interactor.deleteMarker(at: marker.position)
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        self.movedMarkerInitialPosition = marker.position
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        guard let initialPosition = movedMarkerInitialPosition,
              var mapMarker = interactor.getMarkerPresent(at: initialPosition) else {
            return
        }
        
        mapMarker.position = marker.position // update new position
        interactor.deleteMarker(at: initialPosition)
        interactor.addMarker(mapMarker: mapMarker)
    }
}
