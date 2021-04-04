//
//  QuickBloxChatAuthServiceTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest
import Quickblox

class QuickBloxChatAuthServiceTest: XCTestCase {

    var authService = QuickBloxChatAuthService()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        QuickBloxConfiguration.initConfiguration()
        authService = QuickBloxChatAuthService()
    }
    
    func testLogout_notConnected_noOp() {
        authService.logout {
            XCTFail("Should not execute didLogout when not connected")
        }
    }
    
    func testRegisterLoginAndConnectIntegration() {
        let email = "email@email.sg"
        let password = "password"
        let fullName = "fullName"
        authService.registerUser(email: email, password: password, fullName: fullName) { [weak self] in
            XCTAssertTrue(self?.authService.isLoggingIn == false)
            self?.authService.loginAndConnect(email: email,
                                              password: password) { [weak self] _, isSuccessfullyConnected in
                XCTAssertTrue(isSuccessfullyConnected)
                XCTAssertTrue(self?.authService.isLoggingIn == false)
                QBRequest.deleteCurrentUser(successBlock: nil, errorBlock: nil)
            }
        }
        
    }

}
