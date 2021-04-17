//
//  Homestay.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import MapKit

/// Representation of a Booking
struct Homestay: Equatable {
    let homestayId: UUID
    
    let title: String
    
    let description: String?

    /// Paths to images of the homestay
    let images: [String]

    let location: CLLocationCoordinate2D

    let rating: Double

    let fee: Double

    let capacity: HomestayCapacity

    let amenities: [Amenity]

    let guests: Int

    let host: Host
}
