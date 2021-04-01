//
//  LocationManager.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import Combine
import CoreLocation

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
}
