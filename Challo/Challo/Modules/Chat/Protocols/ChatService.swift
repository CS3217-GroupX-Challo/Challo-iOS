//
//  ChatService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Foundation

/// Facade class for chat functionality
///
/// `ChatService`primarily routes operations to their respective handlers
protocol ChatService: AnyObject {
    var chatAuthService: ChatAuthService { get set }
    var chatDialogService: ChatDialogService { get set }
    
    func registerUser(email: String, password: String, fullName: String)
    
    func login(email: String, password: String)
    
    func logout()
    
    func getUnreadMessagesCount(dialogId: String) -> UInt
    
    func getAllDialogs(limit: Int?, skip: Int?)
    
    func createPrivateDialog(with otherUserId: NSNumber)
    
    func sendMessage(messageBody: String, dialogId: String)
    
    func getDialogMessages(dialogId: String)
    
    func getOnlineUsersInDialog(dialogId: String)
}
