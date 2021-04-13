//
//  QuickBloxChatService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatService: ChatService {
    private var chatAuthService: ChatAuthService
    private var chatDialogService: ChatDialogService
    
    var chatUserId: UInt? {
        didSet {
            chatDialogService.chatUserId = chatUserId
        }
    }
    
    var isConnecting: Bool {
        QBChat.instance.isConnecting
    }
    
    var isConnected: Bool {
        QBChat.instance.isConnected
    }
    
    var isLoggingIn: Bool {
        chatAuthService.isLoggingIn
    }
    
    init(chatAuthService: ChatAuthService,
         chatDialogService: ChatDialogService) {
        self.chatAuthService = chatAuthService
        self.chatDialogService = chatDialogService
    }
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?) {
        chatAuthService.connectToChatServer(chatUserId: chatUserId, password: password, didConnect: didConnect)
    }
    
    func loginAndConnect(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        let didLoginUser: ((UInt, Bool) -> Void) = { [weak self] userId, isSuccessful in
            self?.chatUserId = userId
            didLogin?(userId, isSuccessful)
        }
        chatAuthService.loginAndConnect(email: email, password: password, didLogin: didLoginUser)
    }
    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)? = nil) {
        chatAuthService.registerUser(email: email, password: password, fullName: fullName, didRegister: didRegister)
    }
    
    func logout(didLogOut: (() -> Void)?) {
        let afterLogOut: (() -> Void) = { [weak self] in
            self?.chatUserId = nil
            self?.clearDialogsFromRepository()
            didLogOut?()
        }
        chatAuthService.logout(didLogOut: afterLogOut)
    }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        chatDialogService.getUnreadMessagesCount(dialogId: dialogId)
    }
    
    func getAllDialogs(callback: @escaping (([ChatDialog]) -> Void)) {
        chatDialogService.getAllDialogs(callback: callback)
    }
    
    func createPrivateDialog(with email: String, didCreateDialog: @escaping ((ChatDialog) -> Void)) {
        chatDialogService.createPrivateDialog(with: email, didCreateDialog: didCreateDialog)
    }
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?) {
        chatDialogService.sendMessage(messageBody: messageBody, dialogId: dialogId,
                                      willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        chatDialogService.getDialogMessages(dialogId: dialogId, didGetDialogMessages: didGetDialogMessages)
    }
    
    func getDialogWithChateeEmail(_ chateeEmail: String) -> ChatDialog? {
        chatDialogService.getDialogWithChateeEmail(chateeEmail)
    }
    
    func clearDialogsFromRepository() {
        chatDialogService.clearDialogsFromRepository()
    }
    
    func updateUser(name: String, email: String, didUpdateUser: ((Bool) -> Void)?) {
        chatAuthService.updateUser(name: name, email: email, didUpdateUser: didUpdateUser)
    }

}
