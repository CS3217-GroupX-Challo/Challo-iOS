//
//  MessagingSupporter.swift
//  Challo
//
//  Created by Ying Gao on 17/4/21.
//

import Foundation

protocol MessagingSupporter: ObservableObject {

    var sendMessageToUser: ((_ recipientEmail: String, _ recipientId: UUID, _ messageText: String) -> Void)! { get set }
    var messageText: String { get set }

    func sendMessageOnTap(recipient: User)
}

extension MessagingSupporter {

    func sendMessageOnTap(recipient: User) {
        sendMessageToUser(recipient.email, recipient.userId, messageText)
        messageText = ""
    }

}
