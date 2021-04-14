//
//  ChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

/// Service for user authentication in the chat servers
protocol ChatAuthService: AnyObject {
    var isLoggingIn: Bool { get }
    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)?)
    
    func loginAndConnect(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?)
    
    func logout(didLogOut: (() -> Void)?)
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?)
    
    func updateUser(name: String, email: String, profileImg: String?, didUpdateUser: ((Bool) -> Void)?)
}

extension ChatAuthService {
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)? = nil) {
        connectToChatServer(chatUserId: chatUserId, password: password, didConnect: didConnect)
    }

    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)? = nil) {
        registerUser(email: email, password: password, fullName: fullName, didRegister: didRegister)
    }

    func loginAndConnect(email: String, password: String, didLogin: ((UInt, Bool) -> Void)? = nil) {
        loginAndConnect(email: email, password: password, didLogin: didLogin)
    }
    
    func logout(didLogOut: (() -> Void)? = nil) {
        logout(didLogOut: didLogOut)
    }
    
    func updateUser(name: String, email: String, profileImg: String? = nil, didUpdateUser: ((Bool) -> Void)? = nil) {
        updateUser(name: name, email: email, profileImg: profileImg, didUpdateUser: didUpdateUser)
    }
}
