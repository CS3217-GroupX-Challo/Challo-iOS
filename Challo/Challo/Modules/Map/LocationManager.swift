//
//  LocationManager.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import Combine
import CoreLocation
import GoogleMaps

class LocationManager: NSObject, ObservableObject {
    let minimumLongitude: CLLocationDegrees = 70
    let maximumLongitude: CLLocationDegrees = 100
    
    let minimumLatitude: CLLocationDegrees = 25
    let maximumLatitude: CLLocationDegrees = 40
    
    @Published var location = CLLocation(latitude: 28.598_3,
                                         longitude: 83.931_1)
    
    var latitude: CLLocationDegrees {
        location.coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        location.coordinate.longitude
    }
    
    func updateCurrentCoordinates(newLongitude: CLLocationDegrees,
                                  newLatitude: CLLocationDegrees,
                                  mapView: GMSMapView) {
        var currentLatitude = newLatitude
        var currentLongitude = newLongitude
        var snapBack: Bool = false
        
        if currentLatitude < minimumLatitude {
            currentLatitude = minimumLatitude
            snapBack = true
        } else if currentLatitude > maximumLatitude {
            currentLatitude = maximumLongitude
            snapBack = true
        }
        
        if currentLongitude < minimumLongitude {
            currentLongitude = minimumLongitude
            snapBack = true
        } else if currentLongitude > maximumLongitude {
            currentLongitude = maximumLongitude
            snapBack = true
        }
        
        self.location = CLLocation(latitude: currentLatitude,
                                   longitude: currentLongitude)
        
        // if the current view out of bounds (ie over the himalayan regions, snap back to the bounds)
        if snapBack {
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: latitude,
                                                               longitude: longitude))
        }
    }
}
