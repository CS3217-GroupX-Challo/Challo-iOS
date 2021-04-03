//
//  ChatDialogService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Foundation

/// Service for managing all operations involvng ChatDialogs
protocol ChatDialogService: AnyObject {
    var chatUserId: UInt? { get set }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt
    
    func getAllDialogs(limit: Int, skip: Int, callback: (([ChatDialog]) -> Void)?)
    
    func createPrivateDialog(with otherUserId: NSNumber)
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?)
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void))
}

extension ChatDialogService {
    func getAllDialogs(limit: Int = 100, skip: Int = 0, callback: (([ChatDialog]) -> Void)? = nil) {
        getAllDialogs(limit: limit, skip: skip, callback: callback)
    }
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)? = nil,
                     didSendMessage: ((ChatMessage, Error?) -> Void)? = nil) {
        sendMessage(messageBody: messageBody, dialogId: dialogId,
                    willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }

}
