//
//  ChatInteractor.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import Quickblox
import Combine

class ChatInteractor: NSObject, InteractorProtocol {
    weak var presenter: ChatPresenter!
    
    let chatService: ChatService
    private var cancellables: Set<AnyCancellable> = []
    private let userState: UserStateProtocol
    
    init(chatService: ChatService, userState: UserStateProtocol) {
        self.chatService = chatService
        self.userState = userState
        super.init()
        QBChat.instance.addDelegate(self)
        setupUserStateHooks()
    }
    
    var canDisplayChat: Bool {
        userState.loggedIn
    }
    
    func connectToChatServer() {
        guard let chatUserId = chatService.chatUserId else {
            return
        }
        chatService.connectToChatServer(chatUserId: chatUserId, password: userState.userId) { [weak self] _, _ in
            self?.getDialogs()
        }
    }
    
    private func setupUserStateHooks() {
        guard let state = userState as? UserState else {
            fatalError("userState should be of type UserState")
        }
        
        state.$loggedIn.sink(receiveValue: { [weak self] isLoggedIn in
            self?.didIsLoggedInChange(isLoggedIn: isLoggedIn)
        }).store(in: &cancellables)
    }
    
    private func didIsLoggedInChange(isLoggedIn: Bool) {
        guard isLoggedIn else {
            return
        }
        if userState.isNewUser {
            chatService.registerUser(email: userState.email, password: userState.userId,
                                     fullName: userState.name) { [weak self] in
                self?.login()
            }
        } else {
            login()
        }
        
    }
    
    private func login() {
        chatService.login(email: userState.email, password: userState.userId,
                          didLogin: { [weak self] _, isSuccessful in
                            self?.presenter.isChatAvailable = isSuccessful
                            self?.getDialogs()
        })
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
