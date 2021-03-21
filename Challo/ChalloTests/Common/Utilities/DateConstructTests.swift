//
//  Date+ConstructTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest

class DateConstructTests: XCTestCase {
    func testDateConstruct_validDateString_returnsDate() {
        let validDateString = "2021-03-21T04:04:08.170Z"
        XCTAssertNotNil(Date.construct(with: validDateString), "Should not be nil")
    }
}
