//
//  Guide.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

struct Guide: User {
    var userId: UUID
    
    var email: String
    
    var profileImg: String?
    
    var name: String?
    
    var phone: String?
    
    var dateJoined: Date?
    
    var location: Area?
    
    var sex: Sex?
    
    /// A decimal rating of the guide, ranging from 1-5
    let rating: Decimal = 0
    
    /// An array of Days in which the guide is available for booking
    var daysAvailable: [Days] = []
    
    /// An array of trails in which this Guide is capable of servicing
    var trails: [Trail] = []
    
    /// An array of Dates in which the guide has declared unavailable
    var unavailableDates: [Date]?
    
    /// Number of years of experience of the guide
    var yearsOfExperience: Int?
    
    /// An array of languages which the guide speaks
    var languages: [String]?
    
    /// An array of accreditations owned by the guide
    var accreditations: [String]?
    
    /// A short description of the guide
    var biography: String?
}
