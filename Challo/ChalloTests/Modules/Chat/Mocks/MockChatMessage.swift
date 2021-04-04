//
//  MockChatMessage.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import Foundation

class MockChatMessage: ChatMessage {
    let messageId: String
    let message: String
    var isSuccessfullySent: Bool
    let isSentByCurrentUser: Bool
    let senderId: UInt
    let recipientId: UInt
    let dateSent: Date?
    
    init(messageId: String, message: String, isSuccessfullySent: Bool, isSentByCurrentUser: Bool,
         senderId: UInt, recipientId: UInt, dateSent: Date?) {
        self.messageId = messageId
        self.message = message
        self.isSuccessfullySent = isSuccessfullySent
        self.isSentByCurrentUser = isSentByCurrentUser
        self.senderId = senderId
        self.recipientId = recipientId
        self.dateSent = dateSent
    }
}
