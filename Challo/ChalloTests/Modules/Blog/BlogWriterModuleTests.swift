//
//  BlogWriterModuleTests.swift
//  ChalloTests
//
//  Created by Ying Gao on 21/3/21.
//

import XCTest
@testable import Challo

class BlogWriterModuleTests: XCTestCase {

    func testAssemble() {
        let (_, presenter) = BlogWriterModule.assemble()
        guard let interactor = presenter.interactor, let router = presenter.router else {
            XCTFail("Components were not assembled fully")
            return
        }
        XCTAssertNotNil(interactor.presenter, "Components were not assembled fully")
        XCTAssertNotNil(router.presenter, "Components were not assembled fully")
    }

}
