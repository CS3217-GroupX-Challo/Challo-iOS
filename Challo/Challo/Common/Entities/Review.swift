//
//  Review.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a Review
///
/// Representation Invariants:
/// - `guide` is capable of guiding `trail`
/// - `tourist` has a booking for `trail` with `guide`
/// - `rating` is an integer from 1-5
struct Review: Equatable {
    let reviewId: UUID
    
    let rating: Int

    let comment: String
    
    /// Recipient of the review
    let guide: Guide
    
    let trail: Trail
    
    let createdAt: Date
    
    /// Author of the review
    let tourist: Tourist
}
