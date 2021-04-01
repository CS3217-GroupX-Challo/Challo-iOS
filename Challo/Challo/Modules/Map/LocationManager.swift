//
//  LocationManager.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
     @Published var location: CLLocation? {
       willSet { objectWillChange.send() }
     }
    
    var latitude: CLLocationDegrees {
        location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        location?.coordinate.longitude ?? 0
    }
    
    override init() {
      super.init()
    }
}
