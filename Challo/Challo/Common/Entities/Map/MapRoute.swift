//
//  MapRoute.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import Foundation

/// Represents a route on the map, contains
/// start and end marker etc.
struct MapRoute {
    /// unique identification
    var id: UUID
    
    /// Start of the route demarcated by a marker
    var start: MapMarker
    
    /// End of the route demarcated by a marker
    var end: MapMarker
    
    /// Date of the route
    var date: Date?
    
    // Comments for the route
    var comments: String?
}

// MARK: - Extension from equtable
extension MapRoute: Equatable {
    static func == (lhs: MapRoute, rhs: MapRoute) -> Bool {
        lhs.id == rhs.id
    }
}
