//
//  ChatPresenterTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest

class ChatPresenterTest: XCTestCase {

    var presenter = ChatPresenter()
    var userState = MockUserState()
    var interactor = ChatInteractor(chatService: MockChatService(), userState: MockUserState())
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userState = MockUserState()
        presenter = ChatPresenter()
        interactor = ChatInteractor(chatService: MockChatService(), userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
    }

    func testOnTapDialog_validDialogId_gotAllMessages() {
        presenter.onTapDialog(dialogId: MockDialogsMessages.dialogA.dialogId)
        let result = presenter.messages.map { $0.messageId }
        let expected = [MockDialogsMessages.messageAA, MockDialogsMessages.messageAB].map { $0.messageId }
        XCTAssertTrue(Set(result).isSubset(of: expected))
        XCTAssertEqual(presenter.currentOpenDialogId, MockDialogsMessages.dialogA.dialogId)
    }
    
    func testOnTapDialog_invalidDialogId_noMessages() {
        let invalidDialogId = "invalidDialogId"
        presenter.onTapDialog(dialogId: invalidDialogId)
        XCTAssertTrue(presenter.messages.isEmpty)
        XCTAssertEqual(presenter.currentOpenDialogId, invalidDialogId)
    }
    
    func testOnChatAppear_cannotDisplayChat_noOp() {
        userState.loggedIn = false
        presenter.isChatAvailable = true
        presenter.onChatAppear()
        XCTAssertTrue(presenter.dialogs.isEmpty)
        XCTAssertTrue(presenter.messages.isEmpty)
    }
    
    func testOnChatAppear_chatAvailAndCanDisplay_noOp() {
        userState.loggedIn = true
        presenter.isChatAvailable = true
        presenter.onChatAppear()
        let result = presenter.dialogs.map { $0.dialogId }
        let expected = [MockDialogsMessages.dialogA, MockDialogsMessages.dialogB].map { $0.dialogId }
        XCTAssertTrue(Set(result).isSubset(of: expected))
        XCTAssertTrue(presenter.messages.isEmpty)
    }
    
    func testFormatDialogDatetime_withToday_correctFormat() {
        let date = Date()
        let result = presenter.formatDialogDatetime(date)
        let dateFormatter = DateFormatter()
        let format = DateFormatter.dateFormat(fromTemplate: "hh:mm",
                                              options: 0, locale: Locale(identifier: "en-SG"))
        dateFormatter.dateFormat = format
        XCTAssertEqual(result, dateFormatter.string(from: date))
    }
    
    func testFormatDialogDatetime_oneWeekAgo() {
        guard let date = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) else {
            XCTFail("Failed to subtract one week from current date")
            return
        }
        let result = presenter.formatDialogDatetime(date)
        XCTAssertEqual(result, "1 week ago")
    }
    
    func testFormatDialogDatetime_oneMonthAgo() {
        guard let date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else {
            XCTFail("Failed to subtract one month from current date")
            return
        }
        let result = presenter.formatDialogDatetime(date)
        XCTAssertEqual(result, "1 month ago")
    }

}
