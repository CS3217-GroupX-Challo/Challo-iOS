//
//  MockUserState.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockUserState: UserStateProtocol {

    var isNewUser: Bool = false
    var loggedIn = false 
    var email = ""
    var name = ""
    var token = ""
    var userId = ""
    var user: User?
    var certificate: UserCertificate?

    static func createMockLoggedInUserState() -> MockUserState {
        let userState = MockUserState()
        userState.loggedIn = true
        userState.email = "example@example.com"
        userState.name = "Challo"
        userState.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
        userState.userId = "b582bda7-7004-4ce0-92ee-8876c6851436"
        userState.certificate = UserCertificate(name: userState.name,
                                                email: userState.email,
                                                token: userState.token,
                                                userId: userState.userId)
        return userState
    }

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
