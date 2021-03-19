//
//  ReviewState.swift
//  Challo
//
//  Created by Kester Ng on 19/3/21.
//

import Foundation

struct ReviewState {
    let reviewId: UUID
    
    let rating: Int
    
    let comment: String?
    
    let guideId: UUID
    
    let touristId: UUID
    
    let trailId: UUID
    
    let createdAt: Date?
}
