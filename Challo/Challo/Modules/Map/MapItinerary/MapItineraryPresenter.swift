//
//  MapItineraryPresenter.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import GoogleMaps
import MapKit

class MapItineraryPresenter: NSObject, PresenterProtocol {
    var router: MapItineraryRouter?
    var interactor: MapItineraryInteractor!
    
    var locationManager: LocationManager
    var googleMapsView: GoogleMapsView?
    
    override init() {
        let locationManager = LocationManager()
        self.locationManager = locationManager
        super.init()
        self.googleMapsView = GoogleMapsView(locationManager: self.locationManager,
                                             mapDelegate: self)
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
            currentLatitude = locationManager.maximumLongitude
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
}
