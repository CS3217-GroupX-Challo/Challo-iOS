//
//  Homestay.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import MapKit

/// Representation of a Booking
struct Homestay {
    let homestayId: UUID
    
    let title: String
    
    let description: String?

    /// Paths to images of the homestay
    let images: [String]

    let location: CLLocationCoordinate2D

    let rating: Double

    let fee: Double

    let capacity: HomestayCapacity

    let amenities: [Amenities]

    let guests: Int
}
