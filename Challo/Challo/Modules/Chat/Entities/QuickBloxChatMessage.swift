//
//  QuickBloxChatMessage.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatMessage: ChatMessage {
    let chatMessage: QBChatMessage
    let isSentByCurrentUser: Bool
    var isSuccessfullySent: Bool = true
    
    init(chatMessage: QBChatMessage, isSentByCurrentUser: Bool) {
        self.chatMessage = chatMessage
        self.isSentByCurrentUser = isSentByCurrentUser
    }
    
    var messageId: String {
        guard let id = chatMessage.id else {
            fatalError("Received message without an id")
        }
        return id
    }
    
    var message: String {
        chatMessage.text ?? ""
    }
    
    var senderId: UInt {
        chatMessage.senderID
    }
    
    var recipientId: UInt {
        chatMessage.recipientID
    }
    
    var dateSent: Date? {
        chatMessage.dateSent
    }
}
