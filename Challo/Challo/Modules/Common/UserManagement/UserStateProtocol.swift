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
    #if GUIDE
    var completedOnboarding: Bool { get set }
    #endif
    var email: String { get set }
    var name: String { get set }
    var profileImg: String { get set }
    var token: String { get set }
    var userId: String { get set }
    var certificate: UserCertificate? { get }
    var user: User? { get set }

    #if GUIDE
    func storeCertificate(certificate: UserCertificate, isNewUser: Bool, completedOnboarding: Bool)
    #else
    func storeCertificate(certificate: UserCertificate, isNewUser: Bool)
    #endif

    func logIn()

    func logOut()
}

extension UserStateProtocol {

    #if GUIDE
    func storeCertificate(certificate: UserCertificate, isNewUser: Bool = false, completedOnboarding: Bool = true) {
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
        self.completedOnboarding = completedOnboarding

        user = certificate.user
    }
    #else
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
    #endif

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
        #if GUIDE
        completedOnboarding = false
        #endif
    }
}
