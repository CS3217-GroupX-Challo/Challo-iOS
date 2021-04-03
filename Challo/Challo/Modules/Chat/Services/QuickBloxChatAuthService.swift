//
//  QuickBloxChatAuthService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatAuthService: ChatAuthService {
    
    private func connectToChatServer(chatUserId: UInt, password: String) {
        QBChat.instance.connect(withUserID: chatUserId, password: password, completion: { error in
            print(error)
        })
    }
    
    private func disconnect() {
        QBChat.instance.disconnect { _ in
            
        }
    }
    
    func login(email: String, password: String, didLogin: ((UInt) -> Void)?) {
        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { [weak self] _, user in
            self?.connectToChatServer(chatUserId: user.id, password: password)
            didLogin?(user.id)
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
