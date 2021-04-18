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
        let interactor = GuidesListingInteractor(guideRepository: MockGuideRepository())
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        interactor.getAllEntities()
        
        XCTAssertEqual(presenter.entities.count, 2, "Not populated correctly")
        XCTAssertTrue(presenter.entities.allSatisfy([MockGuideAPIResponses.guideTwo,
                                                   MockGuideAPIResponses.guideOne].contains),
                      "Not populated correctly")
    }

}
