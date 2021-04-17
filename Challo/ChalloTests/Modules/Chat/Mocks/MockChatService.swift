//
//  MockChatService.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo

class MockChatService: ChatService {
    var chatUserId: UInt?
    var chatDialogService: ChatDialogService
    var chatAuthService: ChatAuthService
    
    let isConnected: Bool = true
    let isConnecting: Bool = false
    
    var isLoggingIn: Bool {
        get { chatAuthService.isLoggingIn }
        set {
            chatAuthService.isLoggingIn = newValue
        }
    }
    
    init() {
        chatDialogService = MockChatDialogService()
        chatAuthService = MockChatAuthService()
    }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        chatDialogService.getUnreadMessagesCount(dialogId: dialogId)
    }
    
    func createPrivateDialog(with email: String, didCreateDialog: @escaping ((ChatDialog) -> Void)) {
        chatDialogService.createPrivateDialog(with: email, didCreateDialog: didCreateDialog)
    }
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        chatDialogService.getDialogMessages(dialogId: dialogId, didGetDialogMessages: didGetDialogMessages)
    }
    
    func getDialogWithChateeEmail(_ chateeEmail: String) -> ChatDialog? {
        chatDialogService.getDialogWithChateeEmail(chateeEmail)
    }
    
    func registerUser(email: String, password: String, fullName: String, didRegister: (() -> Void)?) {
        chatAuthService.registerUser(email: email, password: password, fullName: fullName, didRegister: didRegister)
    }
    
    func loginAndConnect(email: String, password: String, didLogin: ((UInt, Bool) -> Void)?) {
        chatAuthService.loginAndConnect(email: email, password: password, didLogin: didLogin)
    }
    
    func logout(didLogOut: (() -> Void)?) {
        chatAuthService.logout(didLogOut: didLogOut)
    }
    
    func connectToChatServer(chatUserId: UInt, password: String, didConnect: ((UInt, Bool) -> Void)?) {
        chatAuthService.connectToChatServer(chatUserId: chatUserId, password: password, didConnect: didConnect)
    }
    
    func getAllDialogs(callback: @escaping (([ChatDialog]) -> Void)) {
        chatDialogService.getAllDialogs(callback: callback)
    }
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)? = nil,
                     didSendMessage: ((ChatMessage, Error?) -> Void)? = nil) {
        chatDialogService.sendMessage(messageBody: messageBody, dialogId: dialogId,
                                      willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }
    
    func clearDialogsFromRepository() {
        chatDialogService.clearDialogsFromRepository()
    }
    
    func updateUser(name: String, email: String, didUpdateUser: ((Bool) -> Void)?) {
        chatAuthService.updateUser(name: name, email: email, didUpdateUser: didUpdateUser)
    }

}
