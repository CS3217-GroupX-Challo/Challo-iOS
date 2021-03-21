//
//  BlogPostTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogPostTests: XCTestCase {

    func testRegex() {
        let noTitle = BlogPost(title: "", body: "", author: UUID())
        XCTAssertFalse(noTitle.isValidTitle)

        let onlyWhiteSpace = BlogPost(title: "    ", body: "", author: UUID())
        XCTAssertFalse(onlyWhiteSpace.isValidTitle)

        let validTitle = BlogPost(title: "Some valid string", body: "", author: UUID())
        XCTAssertTrue(validTitle.isValidTitle)
    }

}
