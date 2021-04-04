//
//  ChatModuleTest.swift
//  ChalloTests
//
//  Created by Shao Yi on 4/4/21.
//

@testable import Challo
import XCTest
import SwiftUI

class ChatModuleTest: XCTestCase {

    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let (view, presenter) = ChatModule(chatService: MockChatService(), userState: MockUserState()).assemble()
        XCTAssertNotNil(view, "Nil view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }

}
