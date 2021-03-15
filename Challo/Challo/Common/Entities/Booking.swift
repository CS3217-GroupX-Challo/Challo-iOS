//
//  Booking.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

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
