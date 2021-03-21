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
    
    func testGetLocationOptions_withMockAPI_presenterLocationFilterTypesWithCorrectValues() {
        let interactor = GuidesListingInteractor(guideAPI: MockGuideAPI(),
                                                 areaAPI: MockAreaAPI())
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        interactor.getLocationOptions()
        let filterTypes = presenter.filterTypes
        
        // first value for all filter types is default, hence count = 3, and area location
        // starts from index 1
        XCTAssertEqual(filterTypes.locations.count, 3, "Not populated correctly")
        XCTAssertEqual(filterTypes.locations[1], MockAreaAPIResponse.areaStateOne.village,
                       "Not populated correctly")
        XCTAssertEqual(filterTypes.locations[2], MockAreaAPIResponse.areaStateTwo.village,
                       "Not populated correctly")
    }
}
