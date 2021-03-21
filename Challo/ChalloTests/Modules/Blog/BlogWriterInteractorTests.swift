//
//  BlogWriterInteractorTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogWriterInteractorTests: XCTestCase {

    func testUpdate_changeTitle() {
        let uuid = UUID()
        let blogPost = BlogPost(title: "", body: "", author: uuid)
        let interactor = BlogWriterInteractor(blogPost: blogPost)
        XCTAssertEqual(blogPost, interactor.blogPost)

        interactor.updateBlog() // nothing changed
        XCTAssertEqual(blogPost, interactor.blogPost)

        interactor.updateBlog(title: "Some title")
        var expected = BlogPost(title: "Some title", body: "", author: uuid)
        XCTAssertEqual(expected, interactor.blogPost)

        interactor.updateBlog(title: "      ") // only whitespace
        expected = BlogPost(title: "      ", body: "", author: uuid)
        XCTAssertEqual(expected, interactor.blogPost)

        interactor.updateBlog(title: "")
        XCTAssertEqual(blogPost, interactor.blogPost)
    }

    func testUpdate_changeBody() {
        let uuid = UUID()
        let blogPost = BlogPost(title: "", body: "", author: uuid)
        let interactor = BlogWriterInteractor(blogPost: blogPost)

        interactor.updateBlog(body: "Some body")
        var expected = BlogPost(title: "", body: "Some body", author: uuid)
        XCTAssertEqual(expected, interactor.blogPost)

        interactor.updateBlog(body: "      ") // only whitespace
        expected = BlogPost(title: "", body: "      ", author: uuid)
        XCTAssertEqual(expected, interactor.blogPost)

        interactor.updateBlog(body: "")
        XCTAssertEqual(blogPost, interactor.blogPost)
    }

}
