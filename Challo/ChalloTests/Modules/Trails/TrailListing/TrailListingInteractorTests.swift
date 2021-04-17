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
        interactor.getAllEntities()
        XCTAssertEqual(2, presenter.entities.count, "Not retrived correctly")
        XCTAssertTrue(presenter.entities.allSatisfy([MockTrailAPIResponse.trailOne,
                                                   MockTrailAPIResponse.trailTwo].contains),
                      "Not populated correctly")
    }
}
