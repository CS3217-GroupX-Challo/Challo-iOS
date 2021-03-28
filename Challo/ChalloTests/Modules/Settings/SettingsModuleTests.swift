//
//  SettingsModuleTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class SettingsModuleTests: XCTestCase {
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let (view, presenter) = SettingsModule.assemble(userState: UserState.sampleUserState)
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
