//
//  QuickBloxChatMessageTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest
import Quickblox

class QuickBloxChatMessageTest: XCTestCase {

    var message = QuickBloxChatMessage(chatMessage: QBChatMessage(), isSentByCurrentUser: true)
    
    let senderId: UInt = 1
    let recipientId: UInt = 2
    let dateSent = Date()
    let messageText = "message"
    let messageId: String = "messageId"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let qbMessage = QBChatMessage()
        qbMessage.dateSent = dateSent
        qbMessage.recipientID = recipientId
        qbMessage.senderID = senderId
        qbMessage.id = messageId
        qbMessage.text = messageText
        
        message = QuickBloxChatMessage(chatMessage: qbMessage, isSentByCurrentUser: true)
    }
    
    func testConstruct() {
        XCTAssertTrue(message.isSuccessfullySent)
        XCTAssertTrue(message.isSentByCurrentUser)
    }
    
    func testMessageId() {
        XCTAssertEqual(messageId, message.messageId)
    }
    
    func testMessageText() {
        XCTAssertEqual(messageText, message.message)
    }
    
    func testSenderId() {
        XCTAssertEqual(senderId, message.senderId)
    }
    
    func testRecipientId() {
        XCTAssertEqual(recipientId, message.recipientId)
    }
    
    func testDateSent() {
        XCTAssertEqual(dateSent, message.dateSent)
    }

}
