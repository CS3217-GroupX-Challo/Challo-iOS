//
//  Marker.swift
//  Challo
//
//  Created by Kester Ng on 29/3/21.
//

/// Representation of a marker on a map that represents the users intended travel
import Foundation
import MapKit

struct MapMarker {
    var id: UUID
    
    /// Coordinates of the position of the marker on the map
    var position: CLLocationCoordinate2D
    
    /// Date for which the user decides to visit the location indicated by the marker (if any)
    var date: Date?
    
    /// Comments to take note of for the marker (if any)
    var comments: String?
}

// MARK: - Equatable
extension MapMarker: Equatable {
    static func == (lhs: MapMarker, rhs: MapMarker) -> Bool {
        lhs.id == rhs.id
    }
}
