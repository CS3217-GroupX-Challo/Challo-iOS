//
//  NewReview.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import Foundation

/// Encapsulates the necessary information to create a new Review
struct NewReview {
    
    let bookingId: UUID
    let trailId: UUID
    let guideId: UUID
    let touristId: UUID
    let comments: String
    let rating: Int
}
