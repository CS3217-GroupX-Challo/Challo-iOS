//
//  QuickBloxChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatAuthService: ChatAuthService {
    
    private var isConnected = false
    
    private func connectToChatServer(chatUserId: UInt, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        QBChat.instance.connect(withUserID: chatUserId, password: password, completion: { [weak self] error in
            defer {
                let isSuccessfullyConnected = error == nil
                self?.isConnected = isSuccessfullyConnected
                didLogin?(chatUserId, isSuccessfullyConnected)
            }
            guard error == nil else {
                return
            }
            ChalloLogger.logger.error("Error while attempting to connect to Quickblox server: ")
            ChalloLogger.logger.error("\(error.debugDescription)")
        })
    }
    
    private func disconnect() {
        QBChat.instance.disconnect { _ in
            
        }
    }
    
    func login(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        guard !isConnected else {
            ChalloLogger.logger.fault("A user is already logged in")
            return
        }
        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { [weak self] _, user in
            self?.connectToChatServer(chatUserId: user.id, password: password, didLogin: didLogin)
        }, errorBlock: { response in
            print("Error")
            print(response)
        })
    }
    
    private func createUser(email: String, password: String, fullName: String) -> QBUUser {
        let user = QBUUser()
        user.email = email
        user.fullName = fullName
        user.password = password
        return user
    }
    
    func registerUser(email: String, password: String, fullName: String) {
        let user = createUser(email: email, password: password, fullName: fullName)
        QBRequest.signUp(user, successBlock: { response, user in
            print("Success")
            print(response)
            print(user)
        }, errorBlock: { response in
            print("Error")
            print(response)
        })
    }
    
    func logout() {
        QBRequest.logOut(successBlock: { response in
            print("Success")
            print(response)
        }, errorBlock: { response in
            print("Error")
            print(response)
        })
    }
}
