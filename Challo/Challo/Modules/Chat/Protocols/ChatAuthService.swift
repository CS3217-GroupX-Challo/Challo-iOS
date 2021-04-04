//
//  ChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

/// Service for user authentication in the chat servers
protocol ChatAuthService: AnyObject {    
    func registerUser(email: String, password: String, fullName: String)
    
    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?)
    
    func logout()
}

extension ChatAuthService {
    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)? = nil) {
        login(email: email, password: password, didLogin: didLogin)
    }
}
