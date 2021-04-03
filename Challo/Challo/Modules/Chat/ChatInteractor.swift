//
//  ChatInteractor.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox

class ChatInteractor: NSObject, InteractorProtocol {
    weak var presenter: ChatPresenter!
    
    let chatService: ChatService
    
    override init() {
        let chatDialogRepository = ChatDialogRepository()
        chatService = QuickBloxChatService(chatAuthService: QuickBloxChatAuthService(),
                                           chatDialogService: QuickBloxChatDialogService(chatDialogRepository:
                                                                                            chatDialogRepository))
        super.init()
        chatService.login(email: "abc@abc.sg", password: "abcabcabc") { [weak self] _ in
            self?.getDialogs()
        }
//        chatService.login(email: "test@test.sg", password: "testtesttest")
        QBChat.instance.addDelegate(self)
    }
    
    func getDialogs() {
        presenter.isLoadingDialogs = true
        chatService.getAllDialogs { [weak self] dialogs in
            self?.presenter.dialogs = dialogs
            self?.presenter.isLoadingDialogs = false
        }
    }
    
    func sendMessage(messageBody: String, dialogId: String) {
        chatService.sendMessage(messageBody: messageBody, dialogId: dialogId, willSendMessage: { [weak self] message in
            self?.presenter.messages.append(message)
        }) { [weak self] message, error in
            message.isSuccessfullySent = error == nil
            self?.presenter.objectWillChange.send()
        }
    }
    
    func getDialogMessages(dialogId: String) {
        presenter.isLoadingMessages = true
        chatService.getDialogMessages(dialogId: dialogId) { [weak self] messages in
            self?.didGetDialogMessages(messages)
        }
    }
    
    func didGetDialogMessages(_ messages: [ChatMessage]) {
        presenter.messages = messages
        presenter.isLoadingMessages = false
    }    
}

// MARK: QBChatDelegate
extension ChatInteractor: QBChatDelegate {
    func chatDidReceive(_ message: QBChatMessage) {        
        guard let dialogId = message.dialogID, dialogId == presenter.currentOpenDialogId else {
            return
        }
        presenter.messages.append(QuickBloxChatMessage(chatMessage: message,
                                                       isSentByCurrentUser: message.senderID == chatService.chatUserId))
    }
}
