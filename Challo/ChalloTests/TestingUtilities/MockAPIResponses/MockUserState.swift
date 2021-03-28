//
//  MockUserState.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockUserState: UserStateProtocol {

    var loggedIn = false 
    var email = ""
    var name = ""
    var token = ""
    var userId = ""
    var user: User?
    var certificate: UserCertificate?

    func storeCertificate(certificate: UserCertificate) {
        loggedIn = true
        name = certificate.name
        email = certificate.email
        token = certificate.token
        userId = certificate.userId
        user = certificate.user
        self.certificate = certificate
    }

}
