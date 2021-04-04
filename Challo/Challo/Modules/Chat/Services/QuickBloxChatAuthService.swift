//
//  QuickBloxChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatAuthService: ChatAuthService {
    
    private var isConnected = false
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?) {
        QBChat.instance.connect(withUserID: chatUserId, password: password, completion: { [weak self] error in
            defer {
                let isSuccessfullyConnected = error == nil
                self?.isConnected = isSuccessfullyConnected
                didConnect?(chatUserId, isSuccessfullyConnected)
            }
            if error != nil {
                ChalloLogger.logger.error("Error while attempting to connect to Quickblox server: ")
                ChalloLogger.logger.error("\(error.debugDescription)")
            }
        })
    }
    
    private func disconnect() {
        QBChat.instance.disconnect { [weak self] error in
            guard error == nil else {
                ChalloLogger.logger.error("Error while attempting to disconnect from Quickblox server: ")
                ChalloLogger.logger.error("\(error.debugDescription)")
                return
            }
            self?.isConnected = false
        }
    }
    
    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        guard !isConnected else {
            ChalloLogger.logger.fault("A user is already logged in")
            return
        }
        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { [weak self] _, user in
            self?.connectToChatServer(chatUserId: user.id, password: password, didConnect: didLogin)
        })
    }
    
    private func createUser(email: String, password: String, fullName: String) -> QBUUser {
        let user = QBUUser()
        user.email = email
        user.fullName = fullName
        user.password = password
        return user
    }
    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)? = nil) {
        let user = createUser(email: email, password: password, fullName: fullName)
        QBRequest.signUp(user, successBlock: { _, _ in
            didRegister?()
        })
    }
    
    func logout(didLogOut: (() -> Void)?) {
        guard isConnected else {
            return
        }
        disconnect()
        QBRequest.logOut(successBlock: { _ in
            didLogOut?()
        })

    }
}
