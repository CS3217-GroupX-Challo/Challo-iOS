//
//  GuidesListingInteractorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import XCTest

class GuidesListingInteractorTests: XCTestCase {
    func testPopulateGuides_withMockAPI_presenterGuidesPopulatedWithSameGuidesRetrievedFromAPI() {
        let interactor = GuidesListingInteractor(guideAPI: MockGuideAPI(),
                                                 areaAPI: MockAreaAPI())
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        interactor.populateGuides()
        
        XCTAssertEqual(presenter.guides.count, 2, "Not populated correctly")
        XCTAssertEqual(presenter.guides[0], MockGuideAPIResponses.guideOne, "Not populated correctly")
        XCTAssertEqual(presenter.guides[1], MockGuideAPIResponses.guideTwo, "Not populated correctly")
    }

}
