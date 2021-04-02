//
//  QuickBloxChatDialog.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatDialog: ChatDialog {    
    let chatDialog: QBChatDialog
    
    init(chatDialog: QBChatDialog) {
        self.chatDialog = chatDialog
    }
    
    var unreadMessagesCount: UInt {
        chatDialog.unreadMessagesCount
    }
    
    func sendMessage(_ messageBody: String, didSendMessage: ((Error?) -> Void)?) {
        let message = QBChatMessage()
        message.text = messageBody
        message.customParameters["save_to_history"] = true
        message.markable = true
        chatDialog.send(message, completionBlock: didSendMessage)
    }
    
    func getOnlineUsers(didGetOnlineUsers: @escaping ((NSMutableArray?, Error?) -> Void)) {
        chatDialog.requestOnlineUsers(completionBlock: didGetOnlineUsers)
    }
}
