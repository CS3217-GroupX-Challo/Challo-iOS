//
//  Tourist.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

/// Representation of a Tourist user
import Foundation

struct Tourist: User {
    var userId: UUID
    
    var email: String
    
    var profileImg: String?
    
    var name: String?
    
    var phone: String?
    
    var dateJoined: Date?
    
    var sex: Sex?
}
