//
//  Place.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import MapKit

/// Represents the model for a place on google maps.
struct Place: Equatable {
   
    /// Longitude of the place
    var longitude: CLLocationDegrees
    
    /// Latitude of the place
    var latitude: CLLocationDegrees
    
    /// Name of the place
    var name: String
    
    /// Rating of the place
    var rating: Double
    
    /// Indication whether the place is open
    var isOpen: Bool
    
    /// Address
    var address: String
}
