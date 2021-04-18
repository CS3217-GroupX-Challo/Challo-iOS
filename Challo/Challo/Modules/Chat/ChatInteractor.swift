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
    
    var isLoggingIn: Bool {
        chatService.isLoggingIn
    }
    
    var isConnectingToChatServer: Bool {
        chatService.isConnecting
    }
    
    var isConnected: Bool {
        chatService.isConnected
    }
    
    var userProfileImg: String? {
        userState.profileImg.isEmpty ? nil : userState.profileImg
    }
    
    private func setupUserStateHooks() {
        guard let state = userState as? UserState else {
            return
        }
        
        state.$loggedIn.sink(receiveValue: { [weak self] isLoggedIn in
            self?.didIsLoggedInChange(isLoggedIn: isLoggedIn)
        }).store(in: &cancellables)
    }
    
    private func didIsLoggedInChange(isLoggedIn: Bool) {
        defer {
            if presenter != nil {
                presenter.objectWillChange.send()
            }
        }
        guard isLoggedIn else {
            chatService.logout()
            if presenter != nil {
                presenter.isChatAvailable = false
            }
            return
        }
        guard userState.isNewUser else {
            loginAndConnect()
            return
        }
        chatService.registerUser(email: userState.email, password: userState.userId,
                                 fullName: userState.name) { [weak self] in
            self?.loginAndConnect()
        }
    }
    
    private func didLoginOrConnect(isSuccessful: Bool) {
        presenter.isChatAvailable = isSuccessful
        if isSuccessful {
            getDialogs()
        }
    }
    
    private func loginAndConnect() {
        chatService.loginAndConnect(email: userState.email, password: userState.userId,
                                    didLogin: { [weak self] _, isSuccessful in
                                        self?.didLoginOrConnect(isSuccessful: isSuccessful)
                                    })
    }
    
    func connect() {
        guard let chatUserId = chatService.chatUserId else {
            loginAndConnect()
            return
        }
        chatService.connectToChatServer(chatUserId: chatUserId, password: userState.userId,
                                        didConnect: { [weak self] _, isSuccessful in
                                            self?.didLoginOrConnect(isSuccessful: isSuccessful)
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
    
    private func didGetDialogMessages(_ messages: [ChatMessage]) {
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
    
    func chatDidAccidentallyDisconnect() {
        presenter.isChatAvailable = false
        chatService.isLoggingIn = false
    }
    
    func chatDidDisconnectWithError(_ error: Error?) {
        presenter.isChatAvailable = false
        chatService.isLoggingIn = false
    }
    
    func chatDidConnect() {
        presenter.isChatAvailable = true
    }
}
