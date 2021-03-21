//
//  GuidesListingPresenterTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest

class GuidesListingPresenterTests: XCTestCase {
    func testConstruct() {
        let presenter = GuidesListingPresenter()
        XCTAssertEqual(presenter.filterTypes, FilterTypes(), "Not initialized properly")
        XCTAssertEqual(presenter.languageFilterType, "Default", "Not initialized properly")
        XCTAssertEqual(presenter.ratingFilterType, "Default", "Not initialized properly")
        XCTAssertEqual(presenter.locationFilterType, "Default", "Not initialized properly")
        XCTAssertEqual(presenter.sexFilterType, "Default", "Not initialized properly")
    }
}
