//
//  TrailProfileInteractor.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import XCTest

class TrailProfileInteractorTests: XCTestCase {

    func testGetReviewForTrail_withMockAPI_correctlyReceivesResults() {
        let interactor = TrailProfileInteractor(reviewAPI: MockReviewsAPI())
        let presenter = TrailProfilePresenter()
        interactor.presenter = presenter
        interactor.getReviewsForTrail(trailId: UUID()) { reviews in
            XCTAssertTrue(reviews.isEmpty)
        }
    }
}
