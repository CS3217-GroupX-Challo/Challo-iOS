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
    
    init(chatAuthService: ChatAuthService,
         chatDialogService: ChatDialogService) {
        self.chatAuthService = chatAuthService
        self.chatDialogService = chatDialogService
    }
    
    func login(email: String, password: String, didLogin: ((UInt) -> Void)?) {
        let didLoginUser: ((UInt) -> Void) = { [weak self] userId in
            self?.chatUserId = userId
            didLogin?(userId)
        }
        chatAuthService.login(email: email, password: password, didLogin: didLoginUser)
    }
    
    func registerUser(email: String, password: String, fullName: String) {
        chatAuthService.registerUser(email: email, password: password, fullName: fullName)
    }
    
    func logout() {
        chatAuthService.logout()
    }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        chatDialogService.getUnreadMessagesCount(dialogId: dialogId)
    }
    
    func getAllDialogs(limit: Int, skip: Int, callback: (([ChatDialog]) -> Void)?) {
        chatDialogService.getAllDialogs(limit: limit, skip: skip, callback: callback)
    }
    
    func createPrivateDialog(with otherUserId: NSNumber) {
        chatDialogService.createPrivateDialog(with: otherUserId)
    }
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?) {
        chatDialogService.sendMessage(messageBody: messageBody, dialogId: dialogId,
                                      willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        chatDialogService.getDialogMessages(dialogId: dialogId, didGetDialogMessages: didGetDialogMessages)
    }
}
