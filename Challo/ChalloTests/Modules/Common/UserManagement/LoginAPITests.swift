//
//  LoginAPITests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 28/3/21.
//

@testable import Challo
import XCTest

class LoginAPITests: XCTestCase {

    func testLogin_successLogin_parsedUserReturned() {
        let userAPI = MockUserAPI()
        let loginAPI = LoginAPIImplementation(userAPI: userAPI)
        loginAPI.login(email: "test", password: "test") { response in
            XCTAssertTrue(response.success, "Should successfully log in")
            guard let user = response.certificate?.user as? Tourist else {
                XCTFail("Should parse and return correct user type")
                return
            }
            XCTAssertEqual(user, MockTouristAPIResponse.tourist)
        }
    }

    func testLogin_failLogin_failureResponse() {
        let userAPI = MockUserAPI()
        userAPI.shouldSucceed = false
        let loginAPI = LoginAPIImplementation(userAPI: userAPI)
        loginAPI.login(email: "test", password: "test") { response in
            XCTAssertFalse(response.success, "Should fail to login and callback with a failure response")
        }
    }
}

private class LoginAPIImplementation: LoginAPI {

    var userAPI: UserAPI
    
    var userTypeUrl: String = "/mock"
    
    var networkManager: NetworkManager = MockNetworkManager(json: NetworkManager.JSON())
    
    init(userAPI: UserAPI) {
        self.userAPI = userAPI
    }

    func parseUserTypeJson(json: JSON) -> User? {
        MockTouristAPIResponse.tourist
    }
}
