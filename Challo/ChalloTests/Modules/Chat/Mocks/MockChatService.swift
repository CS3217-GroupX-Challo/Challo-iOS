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
    
    var isConnecting: Bool {
        chatAuthService.isConnecting
    }
}
