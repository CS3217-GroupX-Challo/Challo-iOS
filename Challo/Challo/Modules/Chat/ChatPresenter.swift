//
//  ChatPresenter.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

class ChatPresenter: PresenterProtocol, ObservableObject {
    var router: ChatRouter?
    var interactor: ChatInteractor!
    
    @Published var isChatAvailable: Bool = false
    @Published var isLoadingMessages: Bool = false
    @Published var isLoadingDialogs: Bool = true
    
    @Published var messages: [ChatMessage] = []
    @Published var currentOpenDialogId: String?
    @Published var dialogs: [ChatDialog] = []
    
    @Published var messageText: String = ""
    @Published var dialogSearchBarText: String = ""
    
    var filteredDialogs: [ChatDialog] {
        dialogs.filter({ dialogSearchBarText.isEmpty
                        ? true
                        : $0.chateeName.lowercased().contains(dialogSearchBarText.lowercased()) })
    }
    
    var canDisplayChat: Bool {
        interactor.canDisplayChat
    }
    
    private func resetUnreadMessagesCountForCurrentDialog() {
        guard let dialogId = currentOpenDialogId else {
            fatalError("Attempting to reset unread message count without a current dialog open")
        }
        
        guard let dialog = dialogs.first(where: { $0.dialogId == dialogId }) else {
            fatalError("dialogs does not contain currently open dialog")
        }
        dialog.resetUnreadMessagesCount()
    }
    
    func onTapDialog(dialogId: String) {
        interactor.getDialogMessages(dialogId: dialogId)
        currentOpenDialogId = dialogId
    }
    
    func onTapMessageSend() {
        guard let dialogId = currentOpenDialogId else {
            fatalError("Attempting to send message without a current dialog open")
        }
        interactor.sendMessage(messageBody: messageText, dialogId: dialogId)
        messageText = ""
    }
    
    func formatDialogDatetime(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return CustomDateFormatter.displayDateAsTime(date)
        } else {
            let relativeDateTimeFormatter = RelativeDateTimeFormatter()
            relativeDateTimeFormatter.dateTimeStyle = .numeric
            return relativeDateTimeFormatter.localizedString(for: date, relativeTo: Date())
        }
    }
    
    func makeMessagesView() -> some View {
        var messagesView = [ChatMessageView]()
        var prevSenderId: UInt = 0
        for index in messages.indices {
            let message = messages[index]
            let currentSenderId = message.senderId
            if currentSenderId != prevSenderId, var lastMessageView = messagesView.last {
                lastMessageView.shouldDisplayAvatar = true
                messagesView.append(lastMessageView)
            }
            messagesView.append(ChatMessageView(message: message.message,
                                                isSentByCurrentUser: message.isSentByCurrentUser,
                                                isSuccessfullySent: message.isSuccessfullySent,
                                                shouldDisplayAvatar: index == messages.count - 1))
            prevSenderId = currentSenderId
        }
        return ForEach(messagesView, id: \.self) { message in
            message
        }
    }
    
    func onChatAppear() {
        guard canDisplayChat, isChatAvailable else {
            interactor.connectToChatServer()
            return
        }
        interactor.getDialogs()
    }
}
