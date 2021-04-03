//
//  ChatDialog.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Foundation

/// Representation of a conversation between 2 parties
///
/// Primarily used as a wrapper over a chat SDK's dialog object
/// Chater: current user
/// Chatee: the user whom the chater is messenging to
protocol ChatDialog: AnyObject {
    var dialogId: String { get }
    var unreadMessagesCount: UInt { get }
    var chateeName: String { get }
    var chateeId: UInt { get }
    var lastMessageDate: Date? { get }
    var lastMessageText: String { get }
    
    func sendMessage(_ messageBody: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?)
    
    func resetUnreadMessagesCount()
}
