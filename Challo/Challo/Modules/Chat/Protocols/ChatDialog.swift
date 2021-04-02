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
protocol ChatDialog {
    var unreadMessagesCount: UInt { get }
    
    func sendMessage(_ messageBody: String, didSendMessage: ((Error?) -> Void)?)
    
    func getOnlineUsers(didGetOnlineUsers: @escaping ((NSMutableArray?, Error?) -> Void))
}
