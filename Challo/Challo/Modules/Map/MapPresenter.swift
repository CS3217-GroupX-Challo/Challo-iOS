//
//  MapPresenter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import Combine
import GoogleMaps
import MapKit

@objc
class MapPresenter: NSObject, PresenterProtocol {
    var router: MapRouter?
    var interactor: MapInteractor!
    
    var locationManager: LocationManager
    
    override init() {
        self.locationManager = LocationManager()
        super.init()
    }
}

extension MapPresenter: GMSMapViewDelegate {
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
