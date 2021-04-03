//
//  ChatMessage.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

protocol ChatMessage: AnyObject {
    var messageId: String { get }
    var message: String { get }
    var isSuccessfullySent: Bool { get set }
    var isSentByCurrentUser: Bool { get }
    var senderId: UInt { get }
    var recipientId: UInt { get }
}
