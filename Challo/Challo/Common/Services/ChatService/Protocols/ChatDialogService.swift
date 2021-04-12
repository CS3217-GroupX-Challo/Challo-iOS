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
    
    func getAllDialogs(callback: @escaping (([ChatDialog]) -> Void))
        
    func createPrivateDialog(with email: String, didCreateDialog: @escaping ((ChatDialog) -> Void))
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?)
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void))
    
    func getDialogWithChateeEmail(_ chateeEmail: String) -> ChatDialog?
    
    func clearDialogsFromRepository() 
}

extension ChatDialogService {
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)? = nil,
                     didSendMessage: ((ChatMessage, Error?) -> Void)? = nil) {
        sendMessage(messageBody: messageBody, dialogId: dialogId,
                    willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }

}
