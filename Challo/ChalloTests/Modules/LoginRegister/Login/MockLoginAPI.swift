//
//  LoginAPIMock.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockLoginAPI: LoginAPI {

    typealias JSON = NetworkManager.JSON
    var networkManager: NetworkManager = MockNetworkManager(json: JSON())
    var userAPI: UserAPI = MockUserAPI()
    var userTypeUrl = "/"

    let testEmail = "example@mail.com"
    let testPassword = "strongpassword"
    let wrongEmail = "example@mail.com.sg"
    let wrongPassword = "test"

    let certificate = UserCertificate(name: "example",
                                      email: "example@mail.com",
                                      token: "token",
                                      userId: "123")

    func login(email: String,
               password: String,
               callback: @escaping (UserAPIResponse) -> Void) {
        if email == testEmail && password == testPassword {
            callback(UserAPIResponse(success: true, certificate: certificate))
        } else {
            callback(UserAPIResponse(success: false))
        }
    }

    func parseUserTypeJson(json: JSON) -> User? {
        nil
    }
}
