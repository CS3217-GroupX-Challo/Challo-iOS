//
//  BlogWriterPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogWriterPresenterTests: XCTestCase {

    func testSavingDisabledProperty() {
        let presenter = BlogWriterPresenter()
        presenter.router = BlogWriterRouter()

        let invalidTitleDraft = BlogPost(title: "", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: invalidTitleDraft)
        XCTAssertTrue(presenter.savingDisabled)

        let whitespaceTitleDraft = BlogPost(title: "     ", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: whitespaceTitleDraft)
        XCTAssertTrue(presenter.savingDisabled)

        let validTitleDraft = BlogPost(title: "Some title", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validTitleDraft)
        XCTAssertFalse(presenter.savingDisabled)

        let validDraftEmptyBody = BlogPost(title: "Some title", body: "", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validDraftEmptyBody)
        XCTAssertFalse(presenter.savingDisabled)
    }

    func testPublishDisabledProperty() {
        let presenter = BlogWriterPresenter()
        presenter.router = BlogWriterRouter()

        let invalidTitleInvalidBodyDraft = BlogPost(title: "", body: "    ", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: invalidTitleInvalidBodyDraft)
        XCTAssertTrue(presenter.publishingDisabled)

        let validTitleEmptyBodyDraft = BlogPost(title: "Some title", body: "", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validTitleEmptyBodyDraft)
        XCTAssertFalse(presenter.publishingDisabled)

        let validDraft = BlogPost(title: "Some title", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validDraft)
        XCTAssertFalse(presenter.publishingDisabled)
    }

}
