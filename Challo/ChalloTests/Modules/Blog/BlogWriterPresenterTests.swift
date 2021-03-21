//
//  BlogWriterPresenterTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogWriterPresenterTests: XCTestCase {

    func testSavingEnabledProperty() {
        let presenter = BlogWriterPresenter()
        presenter.router = BlogWriterRouter()

        let invalidTitleDraft = BlogPost(title: "", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: invalidTitleDraft)
        XCTAssertFalse(presenter.savingEnabled)

        let whitespaceTitleDraft = BlogPost(title: "     ", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: whitespaceTitleDraft)
        XCTAssertFalse(presenter.savingEnabled)

        let validTitleDraft = BlogPost(title: "Some title", body: "Random string", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validTitleDraft)
        XCTAssertTrue(presenter.savingEnabled)

        let validDraftEmptyBody = BlogPost(title: "Some title", body: "", author: UUID())
        presenter.interactor = BlogWriterInteractor(blogPost: validDraftEmptyBody)
        XCTAssertTrue(presenter.savingEnabled)
    }

}
