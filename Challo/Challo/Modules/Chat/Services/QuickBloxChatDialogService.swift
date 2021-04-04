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
    
    var dialogsSortedByLastMessageDates: [ChatDialog] {
        chatDialogRepository.getAll().sorted(by: { dialogA, dialogB in
            guard let lastMessageDateA = dialogA.lastMessageDate, let lastMessageDateB = dialogB.lastMessageDate else {
                ChalloLogger.logger.error("Retrieved a dialog with no last message date")
                return false
            }
            return lastMessageDateA > lastMessageDateB
        })
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
            chatDialogRepository.upsert(entity: QuickBloxChatDialog(chatDialog: dialog, occupant: occupant),
                                        key: dialogId)
        }
        callback?(dialogsSortedByLastMessageDates)
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
        let extendedRequest = ["sort_asc": "last_message_date_sent"]
        let responsePage = QBResponsePage(limit: limit, skip: skip)
        QBRequest.dialogs(for: responsePage, extendedRequest: extendedRequest,
                          successBlock: { [weak self] _, dialogs, dialogsUsersIds, _ in
                            self?.didGetAllDialogs(dialogs, dialogsUsersIds, callback)
        })
    }
    
    private func getUserByEmail(_ email: String, didGetUserByEmail: @escaping ((QBUUser) -> Void)) {
        QBRequest.user(withEmail: email, successBlock: { _, user in
            didGetUserByEmail(user)
        }, errorBlock: { _ in
            ChalloLogger.logger.error("Failed to get user")
        })
    }
    
    func createPrivateDialog(with otherUserId: NSNumber, didCreateDialog: @escaping ((ChatDialog) -> Void)) {
        let dialog = QBChatDialog(dialogID: nil, type: .private)
        dialog.occupantIDs = [otherUserId]
        QBRequest.createDialog(dialog, successBlock: { [weak self] _, dialog in
            let userIdSet: Set<NSNumber> = [otherUserId]
            self?.didGetAllDialogs([dialog], userIdSet) { dialogs in
                guard let dialog = dialogs.first else {
                    ChalloLogger.logger.error("Failed to extract chat dialog after creation")
                    return
                }
                didCreateDialog(dialog)
            }
        }, errorBlock: { error in
            ChalloLogger.logger.error("Failed to create dialog")
            ChalloLogger.logger.error("\(error.description)")
        })
    }
    
    func createPrivateDialog(with email: String, didCreateDialog: @escaping ((ChatDialog) -> Void)) {
        getUserByEmail(email) { [weak self] user in
            self?.createPrivateDialog(with: NSNumber(value: user.id), didCreateDialog: didCreateDialog)
        }
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
    
    func getDialogWithChateeEmail(_ chateeEmail: String) -> ChatDialog? {
        chatDialogRepository.getAll().first(where: { $0.chateeEmail == chateeEmail })
    }

}
