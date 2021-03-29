//
//  GuidesModuleTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class GuidesListingModuleTests: XCTestCase {
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let (view, presenter) = GuidesListingModule().assemble()
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
