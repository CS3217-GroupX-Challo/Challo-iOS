//
//  QuickBloxChatDialog.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatDialog: ChatDialog {
    private let chatDialog: QBChatDialog
    let occupant: QBUUser
    
    init(chatDialog: QBChatDialog, occupant: QBUUser) {
        self.chatDialog = chatDialog
        self.occupant = occupant
    }
    
    var dialogId: String {
        guard let id = chatDialog.id else {
            fatalError("Received dialog without an id")
        }
        return id
    }
    
    var unreadMessagesCount: UInt {
        chatDialog.unreadMessagesCount
    }
    
    var chateeName: String {
        occupant.fullName ?? ""
    }
    
    var chateeId: UInt {
        occupant.id
    }
    
    var lastMessageDate: Date {
        chatDialog.lastMessageDate ?? Date()
    }
    
    func sendMessage(_ messageBody: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?) {
        let message = QBChatMessage()
        message.text = messageBody
        message.customParameters["save_to_history"] = true
        message.markable = true
        let wrappedMessage = QuickBloxChatMessage(chatMessage: message, isSentByCurrentUser: true)
        willSendMessage?(wrappedMessage)
        chatDialog.send(message) { error in
            didSendMessage?(wrappedMessage, error)
        }
    }
    
    func resetUnreadMessagesCount() {
        chatDialog.unreadMessagesCount = 0
    }
}
