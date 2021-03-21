//
//  StringRegexCheckTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class StringRegexCheckTests: XCTestCase {

    func testIsEmptyOrOnlyWhiteSpace() {
        let emptyString = ""
        XCTAssertTrue(emptyString.isEmptyOrOnlyWhiteSpace)

        let spaceString = "      "
        XCTAssertTrue(spaceString.isEmptyOrOnlyWhiteSpace)

        let notEmptyString = "Random string"
        XCTAssertFalse(notEmptyString.isEmptyOrOnlyWhiteSpace)
    }

}
