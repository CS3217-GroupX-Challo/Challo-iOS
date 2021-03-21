//
//  TrailListingPresenterTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest
import Dispatch

class TrailListingPresenterTests: XCTestCase {

    func testGetAllTrails_fromMockAPI_correctTrailsPopulated() {
        let interactor = TrailListingInteractor(trailAPI: MockTrailAPI())
        let presenter = TrailListingPresenter()
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.getAllTrails()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            XCTAssertEqual(2, presenter.trails.count, "Not retrived correctly")
            XCTAssertEqual(MockTrailAPIResponse.trailOne, presenter.trails[0], "Not retrived correctly")
            XCTAssertEqual(MockTrailAPIResponse.trailTwo, presenter.trails[1], "Not retrived correctly")
        }
    }
}
