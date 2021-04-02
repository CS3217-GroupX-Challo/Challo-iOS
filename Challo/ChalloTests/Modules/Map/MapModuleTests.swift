//
//  MapModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo
import XCTest
import SwiftUI

class MapModuleTests: XCTestCase {
    typealias JSON = NetworkManager.JSON
    
    func testAssemble_returnsPresenterWithCorrectPropertiesAndView() {
        let (view, presenter) = MapModule(placesAPI: MockPlacesAPI(parser: MockPlacesAPIParser(),
                                                                   networkManager: MockNetworkManager(json: JSON())))
            .assemble()
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
