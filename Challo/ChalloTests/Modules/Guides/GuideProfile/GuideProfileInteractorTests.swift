//
//  GuideProfilePageInteractorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest

class GuideProfileInteractorTests: XCTestCase {
    func testGetReviews_emptyReviews_populatePresenterReviewsWithEmptyArray() {
        let presenter = GuideProfilePresenter(guide: MockGuideAPIResponses.guideOne)
        presenter.interactor = GuideProfileInteractor(reviewAPI: MockReviewsAPI())
        let interactor = presenter.interactor
        interactor?.presenter = presenter
        interactor?.getReviews()
        
        XCTAssertEqual(presenter.reviews.count, 0, "Not working")
    }
}
