//
//  Booking.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a Booking
///
/// Representation Invariants:
/// - `fee` is more than 0 and is given in RP
/// - `guide` is capable of guiding `trail`
/// - `tourist` has a booking for `trail` with `guide`
struct Booking {
    let bookingId: UUID
    
    let fee: Decimal
    
    let date: Date
        
    let status: BookingStatus
    
    let guide: Guide
    
    let trail: Trail
    
    let tourist: Tourist
    
    let review: Review?
}
