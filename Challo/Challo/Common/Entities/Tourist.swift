//
//  Tourist.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Foundation

/// Representation of a Tourist user
struct Tourist: User {
    var userId: UUID
    
    var email: String
    
    var profileImg: String?
    
    var name: String?
    
    var phone: String?
    
    var dateJoined: Date?
    
    var sex: Sex?
}
