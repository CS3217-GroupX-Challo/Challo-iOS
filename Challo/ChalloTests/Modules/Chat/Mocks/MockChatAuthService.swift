//
//  MockChatAuthService.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo

class MockChatAuthService: ChatAuthService {
    var isLoggingIn: Bool = false
    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)?) {
        didRegister?()
    }
    
    func loginAndConnect(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        didLogin?(MockDialogsMessages.currentUserId, true)
    }
    
    func logout(didLogOut: (() -> Void)?) {
        didLogOut?()
    }
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?) {
        didConnect?(chatUserId, true)
    }
}
