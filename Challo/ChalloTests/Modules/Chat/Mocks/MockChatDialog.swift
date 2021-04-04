//
//  MockChatDialog.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import Foundation

class MockChatDialog: ChatDialog {
    let dialogId: String
    
    var unreadMessagesCount: UInt = 1
    
    let chateeEmail: String?
    
    let chateeName: String?
    
    let chateeId: UInt
    
    let lastMessageDate: Date?
    
    let lastMessageText: String
    
    init(dialogId: String, chateeEmail: String, chateeName: String, chateeId: UInt,
         lastMessageDate: Date, lastMessageText: String) {
        self.dialogId = dialogId
        self.chateeEmail = chateeEmail
        self.chateeName = chateeName
        self.chateeId = chateeId
        self.lastMessageDate = lastMessageDate
        self.lastMessageText = lastMessageText
    }
    
    func sendMessage(_ messageBody: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?) {
    }
    
    func resetUnreadMessagesCount() {
        unreadMessagesCount = 0
    }
}
