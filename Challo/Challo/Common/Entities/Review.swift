//
//  Review.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/*
 Representation Invariant: `guide` is capable of guiding `trail`
 */
struct Review {
    let reviewId: UUID
    
    /// Rating is an integer from 1 to 5
    let rating: Int

    let comment: String
    
    let guide: Guide
    
    let trail: Trail
    
    let createdAt: Date
    
    /// The author of the review
    let tourist: Tourist
}
