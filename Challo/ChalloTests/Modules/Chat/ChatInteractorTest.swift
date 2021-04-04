//
//  ChatInteractorTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest

class ChatInteractorTest: XCTestCase {

    let presenter = ChatPresenter()
    var interactor = ChatInteractor(chatService: MockChatService(), userState: MockUserState())
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = ChatInteractor(chatService: MockChatService(), userState: MockUserState())
        interactor.presenter = presenter
    }

    func testGetDialogs_validState_gotAllDialogs() {
        interactor.getDialogs()
        let result = presenter.dialogs.map { $0.dialogId }
        let expected = [MockDialogsMessages.dialogA, MockDialogsMessages.dialogB].map { $0.dialogId }
        XCTAssertTrue(Set(result).isSubset(of: expected))
    }
    
    func testGetDialogMessages_validDialogId_getAllDialogMessages() {
        interactor.getDialogMessages(dialogId: MockDialogsMessages.dialogA.dialogId)
        let result = presenter.messages.map { $0.messageId }
        let expected = [MockDialogsMessages.messageAA, MockDialogsMessages.messageAB].map { $0.messageId }
        XCTAssertTrue(Set(result).isSubset(of: expected))
    }
    
    func testGetDialogMessages_invalidDialogId_noMessages() {
        interactor.getDialogMessages(dialogId: "invalidDialogId")
        XCTAssertTrue(presenter.messages.isEmpty)
    }

}
