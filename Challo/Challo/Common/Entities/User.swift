//
//  User.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a base User in the application
///
/// Representation Invariants:
/// - `profileImg` is a URL to the image stored in a CDN
protocol User {
    /// The unique ID of the user
    var userId: UUID { get }
    
    /// Email of the user, used as primary login
    var email: String { get }
    
    /// Path to the profile Image of the user
    var profileImg: String? { get set }
    
    var name: String? { get set }
    
    var phone: String? { get set }
    
    var dateJoined: Date? { get set }
    
    var sex: Sex? { get set }
}
