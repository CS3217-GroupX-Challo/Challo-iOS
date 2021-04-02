//
//  ChatDialogService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Foundation

/// Service for managing all operations involvng ChatDialogs
protocol ChatDialogService: AnyObject {
    func getUnreadMessagesCount(dialogId: String) -> UInt
    
    func getAllDialogs(limit: Int?, skip: Int?)
    
    func createPrivateDialog(with otherUserId: NSNumber)
    
    func sendMessage(messageBody: String, dialogId: String)
    
    func getDialogMessages(dialogId: String)
    
    func getOnlineUsersInDialog(dialogId: String)
}
