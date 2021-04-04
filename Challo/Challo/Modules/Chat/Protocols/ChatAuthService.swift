//
//  ChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

/// Service for user authentication in the chat servers
protocol ChatAuthService: AnyObject {    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)?)
    
    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?)
    
    func logout(didLogOut: (() -> Void)?)
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?)
}

extension ChatAuthService {
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)? = nil) {
        connectToChatServer(chatUserId: chatUserId, password: password, didConnect: didConnect)
    }

    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)? = nil) {
        registerUser(email: email, password: password, fullName: fullName, didRegister: didRegister)
    }

    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)? = nil) {
        login(email: email, password: password, didLogin: didLogin)
    }
    
    func logout(didLogOut: (() -> Void)? = nil) {
        logout(didLogOut: didLogOut)
    }

}
