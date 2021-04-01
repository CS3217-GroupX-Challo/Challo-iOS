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
    
    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        shouldHandleTap
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        
    }
}
