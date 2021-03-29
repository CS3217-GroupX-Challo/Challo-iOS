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
        let interactor = TrailListingInteractor(trailRepository: MockTrailRepository())
        let presenter = TrailListingPresenter()
        interactor.presenter = presenter
        let trails = interactor.getAllTrails()
        XCTAssertEqual(2, trails.count, "Not retrived correctly")
        XCTAssertTrue(trails.allSatisfy([MockTrailAPIResponse.trailOne, MockTrailAPIResponse.trailTwo].contains),
                      "Not populated correctly")
    }
}
