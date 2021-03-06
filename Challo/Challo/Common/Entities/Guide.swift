//
//  Guide.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a Guide user
///
/// Representation Invariants:
/// - `rating` is a decimal number ranging from 0-5
struct Guide: User, Equatable {
    var userId: UUID
    
    var email: String
    
    var profileImg: String?
    
    var name: String?
    
    var phone: String?
    
    var dateJoined: Date?
    
    var location: Area?
    
    var sex: Sex?
    
    /// Rating of the guide, ranging from 0-5
    var rating: Double = 0
    
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
    
    /// A short description of the guide's hobbies
    var hobbies: String?
    
    /// A short description of the guide's memorable experiences
    var memorableExperiences: String?
}
