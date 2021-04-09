//
//  MapItineraryInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

@testable import Challo
import XCTest
import MapKit

class MapItineraryInteractorTests: XCTestCase {

    private var interactor: MapItineraryInteractor!
    private var mapStore: MapStore!
    private static let itinerary = MapTestConstants.itineraryOne

    override func setUp() {
        super.setUp()
        setUpHelper()
    }

    private func setUpHelper() {
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MapItineraryRepository())
        let interactor = MapItineraryInteractor(mapItinerary: Self.itinerary, mapStore: store)
        self.interactor = interactor
        self.mapStore = store
    }

    func testGetMapMarker_noMarkerAtPosition_returnsNil() {
        let positionWithNoMarkers = CLLocationCoordinate2D(latitude: 23.5,
                                                           longitude: -12.4)
        XCTAssertNil(interactor.getMarkerPresent(at: positionWithNoMarkers), "No marker should be present at location")
    }

    func testGetMapMarker_markerAtPosition_returnsMarker() {
        guard let markerToFind = Self.itinerary.markers.first else {
            XCTFail("Testing with an itinerary without any markers")
            return
        }
        let position = markerToFind.position
        XCTAssertEqual(markerToFind, interactor.getMarkerPresent(at: position),
                       "Marker should be presenter at location")
    }

    func testCreateAndStoreDefaultMarkerThenGet_defaultMarkerCreatedAndRetrievable() {
        let positionToAdd = CLLocationCoordinate2D(latitude: 23.5, longitude: -12.4)
        interactor.createAndStoreDefaultMapMarker(position: positionToAdd)
        guard let defaultMarker = interactor.getMarkerPresent(at: positionToAdd) else {
            XCTFail("Marker should be added to the location")
            return
        }

        XCTAssertNil(defaultMarker.comments, "Default marker should have no comments")
        XCTAssertNil(defaultMarker.date, "Default marker should have no date")
    }

    func testAddMarkerThenGet_markerAddedAndRetrievable() {
        let positionToAdd = CLLocationCoordinate2D(latitude: 23.5, longitude: -12.4)
        let newMarker = MapMarker(id: UUID(),
                                  position: positionToAdd,
                                  date: Date(),
                                  comments: "Hello world!")
        
        interactor.addMarker(mapMarker: newMarker)
        XCTAssertEqual(newMarker, interactor.getMarkerPresent(at: positionToAdd), "Marker should be added to position")
    }

    func testDeleteMarker_noMarkerAtPosition_noChangeToMarkers() {
        let originalMarkers = interactor.mapMarkers
        let positionWithNoMarkers = CLLocationCoordinate2D(latitude: 23.5, longitude: -12.4)
        interactor.deleteMarker(at: positionWithNoMarkers)
        XCTAssertTrue(TestUtils.compareTwoArrays(first: originalMarkers, second: interactor.mapMarkers))
    }

    func testDeleteMarkerThenGet_markerSuccessfullyDeleted() {
        guard let markerToDelete = Self.itinerary.markers.first else {
            XCTFail("Testing on an itinerary with no map markers")
            return
        }
        let position = markerToDelete.position
        interactor.deleteMarker(at: position)
        XCTAssertNil(interactor.getMarkerPresent(at: position), "Marker should have been deleted")
    }
}
