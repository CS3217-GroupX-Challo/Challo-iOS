//
//  GMSMapViewDelegateWrapper.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import GoogleMaps

@objc
class GMSMapViewDelegateWrapper: NSObject, GMSMapViewDelegate {
    var shouldHandleTap: Bool = true
    
    var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        shouldHandleTap
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        locationManager.location = CLLocation(latitude: position.target.latitude,
                                              longitude: position.target.longitude)
    }
}
