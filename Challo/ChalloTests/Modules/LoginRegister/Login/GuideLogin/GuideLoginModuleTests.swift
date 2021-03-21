//
//  GuideLoginModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class GuideLoginModuleTests: XCTestCase {
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let (_, presenter) = GuideLoginModule.assemble()
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
