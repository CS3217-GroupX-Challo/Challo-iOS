//
//  BlogPostTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogPostTests: XCTestCase {

    func testIsValidTitle() {
        let noTitle = BlogPost(title: "", body: "", author: UUID())
        XCTAssertFalse(noTitle.isValidTitle)

        let onlyWhiteSpace = BlogPost(title: "    ", body: "", author: UUID())
        XCTAssertFalse(onlyWhiteSpace.isValidTitle)

        let validTitle = BlogPost(title: "Some valid string", body: "", author: UUID())
        XCTAssertTrue(validTitle.isValidTitle)
    }

    func testCanBePublished() {
        let invalidTitleBlogInvalidText = BlogPost(title: "    ", body: "", author: UUID())
        XCTAssertFalse(invalidTitleBlogInvalidText.canBePublished)

        let invalidTitleBlogValidText = BlogPost(title: "    ", body: "Random Text", author: UUID())
        XCTAssertFalse(invalidTitleBlogValidText.canBePublished)

        let validTitleEmptyText = BlogPost(title: "Some title", body: "", author: UUID())
        XCTAssertFalse(validTitleEmptyText.canBePublished)

        let validTitleOnlyWhiteSpaceText = BlogPost(title: "Some title", body: "      ", author: UUID())
        XCTAssertFalse(validTitleOnlyWhiteSpaceText.canBePublished)

        let validTitleValidText = BlogPost(title: "Some title", body: "Random text", author: UUID())
        XCTAssertTrue(validTitleValidText.canBePublished)
    }

}
