//
//  ChatPresenter.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

class ChatPresenter: SearchBarPresenter, ObservableObject {
    var router: ChatRouter?
    var interactor: ChatInteractor!
    
    // Chat is available when user has connected to the chat server
    @Published var isChatAvailable: Bool = false
    @Published var isLoadingMessages: Bool = false
    @Published var isLoadingDialogs: Bool = false
    
    @Published var messages: [ChatMessage] = []
    @Published var currentOpenDialogId: String?
    @Published var dialogs: [ChatDialog] = []
    
    @Published var messageText: String = ""
    @Published var searchBarText: String = ""
    
    var filteredDialogs: [ChatDialog] {
        dialogs.filter({ searchBarText.isEmpty
                        ? true
                        : ($0.chateeName ?? "").lowercased().contains(searchBarText.lowercased()) })
    }
    
    // Chat can only be displayed when user is logged in
    var canDisplayChat: Bool {
        interactor.canDisplayChat
    }
    
    var isLoadingChat: Bool {
        isLoadingDialogs || interactor.isConnectingToChatServer || interactor.isLoggingIn
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
    
    func onChatAppear() {
        guard canDisplayChat else {
            return
        }
        guard isChatAvailable else {
            if !interactor.isLoggingIn {
                interactor.connect()
            }
            return
        }
        interactor.getDialogs()
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
}

// MARK: UI Rendering Logic
extension ChatPresenter {
    private func makeMessageViewFromMessageIndex(_ index: Int, shouldDisplayAvatar: Bool = false) -> ChatMessageView {
        let message = messages[index]
        return ChatMessageView(message: message.message,
                               isSentByCurrentUser: message.isSentByCurrentUser,
                               isSuccessfullySent: message.isSuccessfullySent,
                               shouldDisplayAvatar: shouldDisplayAvatar || index == messages.count - 1)
    }
    
    private func transformPrevMessageViewToDisplayAvatar(messagesView: inout [AnyView], currentIndex: Int) {
        messagesView.removeLast()
        messagesView.append(AnyView(makeMessageViewFromMessageIndex(currentIndex - 1, shouldDisplayAvatar: true)))
    }
    
    // Should append time when the current message is > 10 minutes apart from the prev message
    private func shouldAppendDateTime(_ currentIndex: Int) -> Bool {
        guard currentIndex != 0 else {
            return true
        }
        guard let dateSent = messages[currentIndex].dateSent,
              let prevDateSent = messages[currentIndex - 1].dateSent else {
            return false
        }
        let diffInSeconds = dateSent.timeIntervalSince(prevDateSent)
        return diffInSeconds > (60 * 10)
    }
    
    private func appendDateTimeWhenNeeded(messagesView: inout [AnyView], currentIndex: Int,
                                          hasTransformedPrevMessage: Bool) {
        let message = messages[currentIndex]
        guard let dateSent = message.dateSent, shouldAppendDateTime(currentIndex) else {
            return
        }
        if !hasTransformedPrevMessage && currentIndex != 0 {
            transformPrevMessageViewToDisplayAvatar(messagesView: &messagesView, currentIndex: currentIndex)
        }
        messagesView.append(AnyView(
            Text(CustomDateFormatter.displayFriendlyDateTime(dateSent))
        ))
    }
    
    func makeMessagesView() -> some View {
        var messagesView = [AnyView]()
        var prevSenderId: UInt = 0
        for index in messages.indices {
            let message = messages[index]
            let currentSenderId = message.senderId
            var hasTransformedPrevMessage = false
            if currentSenderId != prevSenderId && index != 0 {
                transformPrevMessageViewToDisplayAvatar(messagesView: &messagesView, currentIndex: index)
                hasTransformedPrevMessage = true
            }
            appendDateTimeWhenNeeded(messagesView: &messagesView, currentIndex: index,
                                     hasTransformedPrevMessage: hasTransformedPrevMessage)
            messagesView.append(AnyView(makeMessageViewFromMessageIndex(index)))
            prevSenderId = currentSenderId
        }
        return ForEach(messagesView.indices, id: \.self) { index in
            messagesView[index]
        }
    }
}
