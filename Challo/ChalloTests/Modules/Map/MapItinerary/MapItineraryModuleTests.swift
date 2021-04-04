//
//  MapItineraryModuleTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

@testable import Challo
import XCTest

class MapItineraryModuleTests: XCTestCase {

    func testAssemble_withEmptyItinerary_returnsPresenterWithCorrectPropertiesAndView() {
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository())
        let (view, presenter) = MapItineraryModule(placesAPI: MockPlacesAPI(),
                                                   mapStore: store).assemble()
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }

    func testAssemble_withExistingItinerary_returnsPresenterWithCorrectPropertiesAndView() {
        let itinerary = MapTestConstants.itineraryOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository())
        let (view, presenter) = MapItineraryModule(placesAPI: MockPlacesAPI(),
                                                   mapStore: store,
                                                   mapItinerary: itinerary).assemble()
        XCTAssertNotNil(view, "Wrong view returned")
        XCTAssertNotNil(presenter, "Wrong presenter returned")
        XCTAssertNotNil(presenter.router, "Presenter properties not assigned")
        XCTAssertNotNil(presenter.interactor, "Presenter properties not assigned")
    }
}
