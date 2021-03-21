//
//  TrailListingInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class TrailListingInteractorTests: XCTestCase {

    func testGetAllTrails_withMockAPI_correctTrailsReceived() {
        let interactor = TrailListingInteractor(trailAPI: MockTrailAPI())
        let presenter = TrailListingPresenter()
        interactor.presenter = presenter
        interactor.getAllTrails { trails in
            XCTAssertEqual(2, trails.count, "Not retrived correctly")
            XCTAssertEqual(MockTrailAPIResponse.trailOne, trails[0], "Not retrived correctly")
            XCTAssertEqual(MockTrailAPIResponse.trailTwo, trails[1], "Not retrived correctly")
        }
    }
}
