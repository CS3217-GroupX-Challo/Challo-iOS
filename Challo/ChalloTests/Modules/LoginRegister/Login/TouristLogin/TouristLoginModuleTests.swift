//
//  TouristLoginModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class TouristLoginModuleTests: XCTestCase {
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let userState = MockUserState()
        let loginAPI = MockLoginAPI()
        let registerAPI = MockRegisterAPI()
        let (_, presenter) = TouristLoginModule(userState: userState,
                                                loginAPI: loginAPI,
                                                registerAPI: registerAPI).assemble()
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
