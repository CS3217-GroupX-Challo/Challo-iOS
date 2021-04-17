//
//  UserCertificate.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//

struct UserCertificate {
    var name: String
    var email: String
    var profileImg: String
    var token: String
    var userId: String
    var user: User?
}

extension UserCertificate: Equatable {
    static func == (lhs: UserCertificate, rhs: UserCertificate) -> Bool {
        lhs.name == rhs.name &&
        lhs.email == rhs.email &&
        lhs.profileImg == rhs.profileImg &&
        lhs.token == rhs.token &&
        lhs.userId == rhs.userId
    }
}
