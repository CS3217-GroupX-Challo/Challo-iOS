//
//  Trail.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation
import MapKit

struct Trail {
    /// Unique id fo the trail
    let trailId: UUID
    
    let title: String
    
    let description: String
    
    let rating: Double
    
    /// Array of coordinates mapping the route of the trail
    let positions: [CLLocationCoordinate2D]
    
    /// Estimated distance of the trail in meters
    let distance: Double
    
    /// Estimated time needed to complete the trail
    let duration: Double
    
    /// Estimated elevation of the trail in meters
    let elevation: Double
    
    /// Paths to images of the trail
    let images: [String]
    
    /// Geographical area in which the trail resides in
    let area: Area
    
    /// Array of guides who are capable of guiding this trail
    var guides: [Guide] = []
    
    let numOfReviews: Int
    
    let lowestFee: Int
    
    var tags: [String] = []
    
    var landmarks: [String] = []
}
