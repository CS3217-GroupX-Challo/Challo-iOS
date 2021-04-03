//
//  QuickBloxChatDialogService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox
import Foundation
import os

class QuickBloxChatDialogService: ChatDialogService {    
    var chatDialogRepository: ChatDialogRepositoryProtocol
    var chatUserId: UInt?
    
    init(chatDialogRepository: ChatDialogRepositoryProtocol) {
        self.chatDialogRepository = chatDialogRepository
    }
    
    private func getDialogFromId(_ dialogId: String) -> ChatDialog {
        guard let dialog = chatDialogRepository.getByKey(dialogId) else {
            fatalError("dialogId is not found in repository")
        }
        return dialog
    }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        let dialog = getDialogFromId(dialogId)
        return dialog.unreadMessagesCount
    }
    
    private func didGetDialogUsers(_ dialogs: [QBChatDialog], _ users: [QBUUser],
                                   _ callback: (([ChatDialog]) -> Void)?) {
        for dialog in dialogs {
            guard let dialogId = dialog.id else {
                ChalloLogger.logger.error("Retrieved a dialog with no id")
                continue
            }
            let occupantIds = dialog.occupantIDs?.map { $0.uintValue }
            let potentialOccupant = users.first { occupantIds?.contains($0.id) ?? false }
            guard let occupant = potentialOccupant else {
                ChalloLogger.logger.error("Retrieved a user with no matching id")
                continue
            }
            chatDialogRepository.insert(QuickBloxChatDialog(chatDialog: dialog, occupant: occupant), key: dialogId)
        }
        callback?(chatDialogRepository.getAll())
    }
    
    private func didGetAllDialogs(_ dialogs: [QBChatDialog], _ dialogsUsersIds: Set<NSNumber>?,
                                  _ callback: (([ChatDialog]) -> Void)?) {
        let page = QBGeneralResponsePage(currentPage: 1, perPage: 1_000)
        guard let unwrappedUserIds = dialogsUsersIds else {
            ChalloLogger.logger.error("Retrieved dialogsUsersIds as nil")
            return
        }
        let userIds = unwrappedUserIds.map { $0.stringValue }
        guard let currentUserId = chatUserId?.description else {
            fatalError("Attempting to get dialogs before login")
        }
        let userIdsWithoutCurrentUser = userIds.filter { $0 != currentUserId }
        QBRequest.users(withIDs: userIdsWithoutCurrentUser, page: page, successBlock: { [weak self] _, _, users in
            self?.didGetDialogUsers(dialogs, users, callback)
        }, errorBlock: { _ in
            
        })
    }
    
    func getAllDialogs(limit: Int, skip: Int, callback: (([ChatDialog]) -> Void)? = nil) {
        guard chatDialogRepository.getAll().isEmpty else {
            callback?(chatDialogRepository.getAll())
            return
        }
        
        #warning("find default limit")
        let responsePage = QBResponsePage(limit: limit, skip: skip)
        QBRequest.dialogs(for: responsePage, extendedRequest: nil,
                          successBlock: { [weak self] _, dialogs, dialogsUsersIds, _ in
                            self?.didGetAllDialogs(dialogs, dialogsUsersIds, callback)
        }, errorBlock: { error in
            print(error)
        })
    }
    
    func createPrivateDialog(with otherUserId: NSNumber) {
        let dialog = QBChatDialog(dialogID: nil, type: .private)
        dialog.occupantIDs = [otherUserId]
        QBRequest.createDialog(dialog, successBlock: { _, _ in
            
        }, errorBlock: { _ in
            
        })
    }
    
    func sendMessage(messageBody: String, dialogId: String, willSendMessage: ((ChatMessage) -> Void)?,
                     didSendMessage: ((ChatMessage, Error?) -> Void)?) {
        let dialog = getDialogFromId(dialogId)
        dialog.sendMessage(messageBody, willSendMessage: willSendMessage, didSendMessage: didSendMessage)
    }
    
    private func onGetDialogMessagesSuccess(messages: [QBChatMessage],
                                            didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        let wrappedMessages = messages.map { QuickBloxChatMessage(chatMessage: $0,
                                                                  isSentByCurrentUser: $0.senderID == chatUserId) 
        }
        didGetDialogMessages(wrappedMessages)
    }
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        let page = QBResponsePage(limit: 100, skip: 0)
        let extendedRequest = ["sort_asc": "date_sent"]
        QBRequest.messages(withDialogID: dialogId, extendedRequest: extendedRequest, for: page,
                           successBlock: { [weak self] _, messages, _ in
                            self?.onGetDialogMessagesSuccess(messages: messages,
                                                             didGetDialogMessages: didGetDialogMessages)
        }, errorBlock: { _ in
            
        })
    }
}
