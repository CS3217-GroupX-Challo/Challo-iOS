//
//  Host.swift
//  Challo
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation

struct Host: User {
    var userId: UUID
    
    var email: String
    
    var profileImg: String?
    
    var name: String?
    
    var phone: String?
    
    var dateJoined: Date?
    
    var sex: Sex?
}

extension Host: Equatable {
    
}
