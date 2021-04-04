//
//  MockDialogsMessages.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

import Foundation

struct MockDialogsMessages {
    static let currentUserId: UInt = 0
        
    static let dialogA = MockChatDialog(dialogId: "dialogA",
                                        chateeEmail: "dialogA_email",
                                        chateeName: "dialogA_email",
                                        chateeId: 1,
                                        lastMessageDate: Date(),
                                        lastMessageText: "dialogA_lastMessageText")
    
    static let dialogB = MockChatDialog(dialogId: "dialogB",
                                        chateeEmail: "dialogB_email",
                                        chateeName: "dialogB_email",
                                        chateeId: 2,
                                        lastMessageDate: Date(),
                                        lastMessageText: "dialogB_lastMessage")
    
    static let messageAA = MockChatMessage(messageId: "messageAA", message: "messageAA_message",
                                           isSuccessfullySent: true,
                                           isSentByCurrentUser: true,
                                           senderId: currentUserId,
                                           recipientId: 1,
                                           dateSent: Date())
    
    static let messageAB = MockChatMessage(messageId: "messageAB", message: "messageAB_message",
                                           isSuccessfullySent: true,
                                           isSentByCurrentUser: false,
                                           senderId: 1,
                                           recipientId: currentUserId,
                                           dateSent: Date())
    
    static let messageBA = MockChatMessage(messageId: "messageBA", message: "messageBA_message",
                                           isSuccessfullySent: true,
                                           isSentByCurrentUser: true,
                                           senderId: currentUserId,
                                           recipientId: 2,
                                           dateSent: Date())
    
    static let messageBB = MockChatMessage(messageId: "messageBB", message: "messageBB_message",
                                           isSuccessfullySent: true,
                                           isSentByCurrentUser: false,
                                           senderId: 2,
                                           recipientId: currentUserId,
                                           dateSent: Date())
}
