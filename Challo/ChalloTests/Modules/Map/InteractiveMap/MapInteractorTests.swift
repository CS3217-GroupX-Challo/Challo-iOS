//
//  MapInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

@testable import Challo
import XCTest

class MapInteractorTests: XCTestCase {

    private var interactor: MapInteractor!
    private var presenter: MapPresenter!

    override func setUp() {
        super.setUp()
        let mapStore = MapStore(mapMarkerRepository: MockMarkerRepository(),
                                mapRouteRepository: MockRouteRepository(),
                                mapItineraryRepository: MockItineraryRepository())
        let interactor = MapInteractor(mapStore: mapStore, placesAPI: MockPlacesAPI())
        let presenter = MapPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        self.interactor = interactor
        self.presenter = presenter
    }

    func testGetPlaces_noPlacesRetrieved_presenterFoundPlacesEmpty() {
        let wrongName = "wrong name"
        interactor.getPlaces(with: wrongName)
        XCTAssertTrue(presenter.foundPlaces.isEmpty)
    }

    func testGetPlaces_placesRetrieved_presenterFoundPlacesPopulated() {
        let correctName = MockPlacesAPI.correctName
        interactor.getPlaces(with: correctName)
        XCTAssertTrue(TestUtils.compareTwoArrays(first: presenter.foundPlaces,
                                                 second: MockPlacesAPI.places))
    }
}
