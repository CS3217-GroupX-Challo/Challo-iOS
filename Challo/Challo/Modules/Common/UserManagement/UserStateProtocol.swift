//
//  UserStateProtocol.swift
//  Challo
//
//  Created by Tan Le Yang on 21/3/21.
//

import Combine
import Foundation

protocol UserStateProtocol: AnyObject {

    var isNewUser: Bool { get set }
    var loggedIn: Bool { get set }
    var email: String { get set }
    var name: String { get set }
    var profileImg: String { get set }
    var token: String { get set }
    var userId: String { get set }
    var certificate: UserCertificate? { get }
    var user: User? { get set }
    
    func storeCertificate(certificate: UserCertificate, isNewUser: Bool)

    func logIn()

    func logOut()
}

extension UserStateProtocol {

    func storeCertificate(certificate: UserCertificate, isNewUser: Bool = false) {
        defer {
            // assignment of loggedIn is placed last as subscribers to the loggedIn state
            // may read other attributes of userState
            loggedIn = true
        }
        name = certificate.name
        email = certificate.email
        profileImg = certificate.profileImg
        token = certificate.token
        userId = certificate.userId
        self.isNewUser = isNewUser

        user = certificate.user
    }

    func logIn() {
        loggedIn = true
    }

    func logOut() {
        loggedIn = false
        name = ""
        email = ""
        profileImg = ""
        token = ""
        userId = ""
        user = nil
        isNewUser = false
    }
}
