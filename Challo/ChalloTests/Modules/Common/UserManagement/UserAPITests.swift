//
//  UserAPITests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 28/3/21.
//

@testable import Challo
import XCTest

class UserAPITests: XCTestCase {
    typealias JSON = NetworkManager.JSON

    func testCommonLogin_successResponse_successfulLogin() {
        let parser = MockUserAPIParser()
        var successJSON = JSON()
        successJSON["success"] = true
        let userAPI = UserAPI(userParser: parser, networkManager: MockNetworkManager(json: successJSON))
        userAPI.commonLogin(credentials: JSON()) { response in
            XCTAssertTrue(response.success)
            XCTAssertEqual(MockUserAPIResponses.certificate, response.certificate)
        }
    }

    func testCommonLogin_failureResponse_loginFailure() {
        let parser = MockUserAPIParser()
        var failureJSON = JSON()
        failureJSON["success"] = false
        let userAPI = UserAPI(userParser: parser, networkManager: MockNetworkManager(json: failureJSON))
        userAPI.commonLogin(credentials: JSON()) { response in
            XCTAssertFalse(response.success)
            XCTAssertNil(response.certificate)
        }
    }

    func testCommonRegister_successResponse_successfulRegister() {
        let parser = MockUserAPIParser()
        var successJSON = JSON()
        successJSON["success"] = true
        let userAPI = UserAPI(userParser: parser, networkManager: MockNetworkManager(json: successJSON))
        userAPI.commonRegister(details: JSON()) { response in
            XCTAssertTrue(response.success)
            XCTAssertEqual(MockUserAPIResponses.certificate, response.certificate)
        }
    }

    func testCommonRegister_failureResponse_registerFailure() {
        let parser = MockUserAPIParser()
        var failureJSON = JSON()
        failureJSON["success"] = false
        let userAPI = UserAPI(userParser: parser, networkManager: MockNetworkManager(json: failureJSON))
        userAPI.commonRegister(details: JSON()) { response in
            XCTAssertFalse(response.success)
            XCTAssertNil(response.certificate)
        }
    }
}
