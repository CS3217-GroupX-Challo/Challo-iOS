//
//  MockRegisterAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockRegisterAPI: RegisterAPI {

    typealias JSON = NetworkManager.JSON
    var userAPI: UserAPI = MockUserAPI()
    var networkManager: NetworkManager = MockNetworkManager(json: JSON())
    var userTypeUrl = ""
    var shouldSucceed = true

    let details = RegistrationDetails(name: "name",
                                      phone: "12345678",
                                      email: "name@example.com",
                                      password: "password")
    let certificate = UserCertificate(name: "name",
                                      email: "name@example.com",
                                      token: "token",
                                      userId: "123")

    func register(details: RegistrationDetails, callback: @escaping (UserAPIResponse) -> Void) {
        if shouldSucceed {
            callback(UserAPIResponse(success: true, certificate: certificate))
        } else {
            callback(UserAPIResponse(success: false))
        }
    }

    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> JSON? {
        JSON()
    }
    
    func parseUserTypeJSON(json: JSON) -> User? {
        nil
    }
}
