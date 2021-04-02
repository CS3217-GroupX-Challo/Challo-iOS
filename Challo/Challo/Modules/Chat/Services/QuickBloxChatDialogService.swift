//
//  QuickBloxChatDialogService.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class QuickBloxChatDialogService: ChatDialogService {
    
    var chatDialogRepository: ChatDialogRepositoryProtocol
    
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
    
    func getAllDialogs(limit: Int? = nil, skip: Int? = nil) {
        #warning("find default limit")
        let responsePage = QBResponsePage(limit: limit ?? 0, skip: skip ?? 0)
        QBRequest.dialogs(for: responsePage, extendedRequest: nil, successBlock: { _, _, _, _ in

        }, errorBlock: { _ in
            
        })
    }
    
    func createPrivateDialog(with otherUserId: NSNumber) {
        let dialog = QBChatDialog(dialogID: nil, type: .private)
        dialog.occupantIDs = [otherUserId]
        QBRequest.createDialog(dialog, successBlock: { _, _ in
            
        }, errorBlock: { _ in
            
        })
    }
    
    func didSendMessage(_ error: Error?) {
        guard error == nil else {
            print(error)
            return
        }
        
    }
    
    func sendMessage(messageBody: String, dialogId: String) {
        let dialog = getDialogFromId(dialogId)
        dialog.sendMessage(messageBody) { [weak self] error in
            self?.didSendMessage(error)
        }
    }
    
    func getDialogMessages(dialogId: String) {
        let page = QBResponsePage(limit: 50, skip: 100)
        let extendedRequest = ["sort_desc": "date_sent"]
        QBRequest.messages(withDialogID: dialogId, extendedRequest: extendedRequest, for: page, successBlock: { _, _, _ in

        }, errorBlock: { _ in
            
        })
    }
    
    func getOnlineUsersInDialog(dialogId: String) {
        let dialog = getDialogFromId(dialogId)
        dialog.getOnlineUsers { onlineUsersIDs, error in
            guard error == nil else {
                return
            }
            print(onlineUsersIDs)
        }
    }
}
