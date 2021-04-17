//
//  RegisterAPITest.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 28/3/21.
//

@testable import Challo
import XCTest

class RegisterAPITests: XCTestCase {

    private let details = RegistrationDetails(name: "test",
                                              phone: "12345678",
                                              email: "test@example.com",
                                              password: "abc")

    func testRegister_successRegister_parsedUserReturned() {
        let userAPI = MockUserAPI()
        let registerAPI = RegisterAPIImplementation(userAPI: userAPI)

        registerAPI.register(details: details) { response in
            XCTAssertTrue(response.success, "Should successfully register")
            guard let user = response.certificate?.user as? Tourist else {
                XCTFail("Should parse and return correct user type")
                return
            }
            XCTAssertEqual(user, MockTouristAPIResponse.tourist)
        }
    }

    func testRegister_failRegister_failureResponse() {
        let userAPI = MockUserAPI()
        userAPI.shouldSucceed = false
        let registerAPI = RegisterAPIImplementation(userAPI: userAPI)
        
        registerAPI.register(details: details) { response in
            XCTAssertFalse(response.success, "Should fail to register and callback with a failure response")
        }
    }
}

private class RegisterAPIImplementation: RegisterAPI {

    var userAPI: UserAPIProtocol
    
    var userTypeUrl: String = "mock"
    
    var networkManager: NetworkManager = MockNetworkManager(json: NetworkManager.JSON())

    init(userAPI: UserAPIProtocol) {
        self.userAPI = userAPI
    }
    
    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> NetworkManager.JSON? {
        MockTouristAPIResponse.validTouristJSON
    }
    
    func parseUserTypeJSON(json: JSON) -> User? {
        MockTouristAPIResponse.tourist
    }
}
