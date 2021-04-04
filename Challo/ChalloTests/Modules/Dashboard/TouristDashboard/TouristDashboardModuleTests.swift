//
//  TouristDashboardModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class TouristDashboardModuleTests: XCTestCase {

    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let userState = MockUserState()
        let bookingsRepository = MockBookingRepository()
        let (view, presenter) = TouristDashboardModule(userState: userState,
                                                       bookingsRepository: bookingsRepository,
                                                       sendMessageToGuide: { _, _, _ in }).assemble()
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
