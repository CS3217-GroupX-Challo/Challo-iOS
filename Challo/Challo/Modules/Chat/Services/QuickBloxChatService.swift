//
//  QuickBloxChatService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox


class QuickBloxChatService: ChatService {
    
    var chatAuthService: ChatAuthService
    var chatDialogService: ChatDialogService
    
    init(chatAuthService: ChatAuthService,
         chatDialogService: ChatDialogService) {
        self.chatAuthService = chatAuthService
        self.chatDialogService = chatDialogService
    }
    
    private func connectToChatServer(chatUserId: UInt, password: String) {
        QBChat.instance.connect(withUserID: chatUserId, password: password, completion: { error in
            print(error)
        })
    }
    
    private func disconnect() {
        QBChat.instance.disconnect { _ in
            
        }
    }
    
    func login(email: String, password: String) {
        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { response, user in
            print("Success")
            print(response)
            print(user)
        }, errorBlock: { response in
            print("Error")
            print(response)
        })
    }
    
    func registerUser(email: String, password: String, fullName: String) {
        chatAuthService.registerUser(email: email, password: password, fullName: fullName)
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
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        chatDialogService.getUnreadMessagesCount(dialogId: dialogId)
    }
    
    func getAllDialogs(limit: Int? = nil, skip: Int? = nil) {
        chatDialogService.getAllDialogs(limit: limit, skip: skip)
    }
    
    func createPrivateDialog(with otherUserId: NSNumber) {
        chatDialogService.createPrivateDialog(with: otherUserId)
    }
    
    func sendMessage(messageBody: String, dialogId: String) {
        chatDialogService.sendMessage(messageBody: messageBody, dialogId: dialogId)
    }
    
    func getDialogMessages(dialogId: String) {
        chatDialogService.getDialogMessages(dialogId: dialogId)
    }
    
    func getOnlineUsersInDialog(dialogId: String) {
        chatDialogService.getOnlineUsersInDialog(dialogId: dialogId)
    }
    
}
