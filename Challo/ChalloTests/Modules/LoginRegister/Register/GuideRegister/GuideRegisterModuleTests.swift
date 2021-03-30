//
//  GuideRegisterModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class GuideRegisterModuleTests: XCTestCase {
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let userState = MockUserState()
        let (_, presenter) = GuideRegisterModule(userState: userState).assemble()
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
