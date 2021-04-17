//
//  MapItinerary.swift
//  Challo
//
//  Created by Kester Ng on 31/3/21.
//

import Foundation

/// Models an itinerary for a tourist.
class MapItinerary {

    init(id: UUID,
         routes: [MapRoute],
         markers: [MapMarker],
         title: String,
         createdAt: Date,
         lastModified: Date) {
        self.id = id
        self.routes = routes
        self.markers = markers
        self.title = title
        self.createdAt = createdAt
        self.lastModified = lastModified
    }

    /// Unique identification
    var id: UUID
    
    /// Routes stored in an itinerary
    var routes: [MapRoute]
    
    /// Markers present on the itinerary
    var markers: [MapMarker]
    
    /// Title of the itinerary
    var title: String
    
    /// Date of creation
    var createdAt: Date

    /// Last modified on
    var lastModified: Date
}

// MARK: - Equtable
extension MapItinerary: Equatable {
    static func == (lhs: MapItinerary, rhs: MapItinerary) -> Bool {
        lhs.id == rhs.id
    }
}
