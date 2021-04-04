//
//  QuickBloxChatDialogTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest
import Quickblox

class QuickBloxChatDialogTest: XCTestCase {

    var dialog = QuickBloxChatDialog(chatDialog: QBChatDialog(dialogID: "dialogId", type: .private),
                                     occupant: QBUUser())
    
    let dialogId = "dialogId"
    let lastMessageDate = Date()
    let lastMessageText = "lastMessageText"
    let chateeName = "chateeName"
    let chateeId: UInt = 123
    let chateeEmail = "chateeEmail"
    let unreadMessagesCount: UInt = 1
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let qbDialog = QBChatDialog(dialogID: dialogId, type: .private)
        qbDialog.lastMessageDate = lastMessageDate
        qbDialog.lastMessageText = lastMessageText
        qbDialog.unreadMessagesCount = unreadMessagesCount
        let occupant = QBUUser()
        occupant.fullName = chateeName
        occupant.id = chateeId
        occupant.email = chateeEmail
        dialog = QuickBloxChatDialog(chatDialog: qbDialog, occupant: occupant)
    }
    
    func testDialogId() {
        XCTAssertEqual(dialogId, dialog.dialogId)
    }
    
    func testUnreadMessagesCount() {
        XCTAssertEqual(unreadMessagesCount, dialog.unreadMessagesCount)
    }
    
    func testLastMessageDate() {
        XCTAssertEqual(lastMessageDate, dialog.lastMessageDate)
    }
    
    func testLastMessageText() {
        XCTAssertEqual(lastMessageText, dialog.lastMessageText)
    }
    
    func testChateeName() {
        XCTAssertEqual(chateeName, dialog.chateeName)
    }
    
    func testChateeId() {
        XCTAssertEqual(chateeId, dialog.chateeId)
    }
    
    func testChateeEmail() {
        XCTAssertEqual(chateeEmail, dialog.chateeEmail)
    }
    
    func testResetMessagesCount_countSetToZero() {
        dialog.resetUnreadMessagesCount()
        XCTAssertEqual(0, dialog.unreadMessagesCount)
    }
    
    func testSendMessage() {
        let messageText = "Hello world"
        dialog.sendMessage(messageText, willSendMessage: { message in
            XCTAssertEqual(messageText, message.message)
            XCTAssertTrue(message.isSentByCurrentUser)
        }, didSendMessage: nil)
    }

}
