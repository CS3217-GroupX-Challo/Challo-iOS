//
//  ItineraryMapMarkerRepositoryTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

@testable import Challo
import Foundation
import XCTest
import MapKit

class ItineraryMapMarkerRepositoryTests: XCTestCase {

    func testGetMapMarker_noMarkerAtPosition_returnsNil() {
        let repo = ItineraryMapMarkerRepository()
        XCTAssertNil(repo.getMapMarker(at: CLLocationCoordinate2D(latitude: 10, longitude: 10)),
                     "Should have no marker at given position")
    }

    func testAddMarkerThenGetMapMarker_markerAddedAndRetrievable() {
        let markerToAdd = MapTestConstants.markerOne
        let position = markerToAdd.position
        let repo = ItineraryMapMarkerRepository()
        repo.addMapMarker(mapMarker: markerToAdd)
        XCTAssertEqual(markerToAdd, repo.getMapMarker(at: position),
                       "Marker should be added at given position")
    }

    func testAddMarkerThenDeleteMarker_markerAddedThenDeleted() {
        let markerToAdd = MapTestConstants.markerOne
        let position = markerToAdd.position
        let repo = ItineraryMapMarkerRepository()
        repo.addMapMarker(mapMarker: markerToAdd)
        XCTAssertEqual(markerToAdd, repo.getMapMarker(at: position))
        repo.deleteMapMarker(at: position)
        XCTAssertNil(repo.getMapMarker(at: position),
                     "Marker at position should have been deleted")
    }

    func testGetAllMapMarkers_noMapMarkersAdded_returnsEmptyList() {
        let repo = ItineraryMapMarkerRepository()
        XCTAssertTrue(repo.getAllMapMarkers().isEmpty,
                      "Empty repository should have no markers")
    }

    func testAddMarkersThenGetAllMapMarkers_multipleMarkers_allMarkersAddedAndRetrieved() {
        let markersToAdd = [MapTestConstants.markerOne,
                            MapTestConstants.markerTwo,
                            MapTestConstants.markerThree]
        let repo = ItineraryMapMarkerRepository()
        markersToAdd.forEach {
            repo.addMapMarker(mapMarker: $0)
        }
        let retrievedMarkers = repo.getAllMapMarkers()
        XCTAssertEqual(markersToAdd.count, retrievedMarkers.count)
        markersToAdd.forEach {
            XCTAssertTrue(retrievedMarkers.contains($0), "All markers should be added")
        }
    }

    func testcreateAndStoreDefaultMapMarkerThenGet_markerCreatedAndRetrievableDateAndCommentsNil() throws {
        let repo = ItineraryMapMarkerRepository()
        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        repo.createAndStoreDefaultMapMarker(at: position)
        let retrieved = try XCTUnwrap(repo.getMapMarker(at: position))
        XCTAssertNil(retrieved.comments, "Default markers should have no comments")
        XCTAssertNil(retrieved.date, "Default markers should have no date")
    }
}
