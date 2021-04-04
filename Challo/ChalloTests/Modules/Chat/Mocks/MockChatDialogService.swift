//
//  MockChatDialogService.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import Foundation

class MockChatDialogService: ChatDialogService {
    var chatUserId: UInt? = MockDialogsMessages.currentUserId
    var dialogRepository: ChatDialogRepositoryProtocol
    
    init() {
        dialogRepository = MockChatDialogRepository()
    }
    
    func getUnreadMessagesCount(dialogId: String) -> UInt {
        dialogRepository.getAll().first(where: { $0.dialogId == dialogId })?.unreadMessagesCount ?? 0
    }
    
    func createPrivateDialog(with email: String, didCreateDialog: @escaping ((ChatDialog) -> Void)) {
        let dialog = MockChatDialog(dialogId: email, chateeEmail: email, chateeName: email, chateeId: 99,
                                    lastMessageDate: Date(), lastMessageText: email)
        didCreateDialog(dialog)
    }
    
    func getDialogMessages(dialogId: String, didGetDialogMessages: @escaping (([ChatMessage]) -> Void)) {
        switch dialogId {
        case MockDialogsMessages.dialogA.dialogId:
            didGetDialogMessages([MockDialogsMessages.messageAA, MockDialogsMessages.messageAB])
        case MockDialogsMessages.dialogB.dialogId:
            didGetDialogMessages([MockDialogsMessages.messageBA, MockDialogsMessages.messageBB])
        default:
            didGetDialogMessages([])
        }
    }
    
    func getDialogWithChateeEmail(_ chateeEmail: String) -> ChatDialog? {
        dialogRepository.getAll().first(where: { $0.chateeEmail == chateeEmail })
    }
}
