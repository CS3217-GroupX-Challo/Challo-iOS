//
//  MapStoreTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import XCTest
import MapKit

class MapStoreTests: XCTestCase {

    func testGetAllMapMarkers_correctMarkersReturned() {
        let markerRepository = MockMarkerRepository()
        let store = MapStore(mapMarkerRepository: markerRepository,
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapMarkers(),
                                                 second: markerRepository.allMarkers),
                      "Store should return same markers as repository")
    }

    func testGetAllMapMarkers_emptyRepository_noMarkersReturned() {
        let markerRepository = MockMarkerRepository.createEmptyRepo()
        let store = MapStore(mapMarkerRepository: markerRepository,
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        XCTAssertTrue(store.getAllMapMarkers().isEmpty,
                      "Store should return same markers as repository")
    }

    func testSaveMapMarkers_oneMarker_nothingHappens() {
        let markerToSave = MapTestConstants.markerOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository.createEmptyRepo(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        store.saveMapMarkers(mapMarkers: [markerToSave])
        XCTAssertEqual(store.getAllMapMarkers().count, 0, "Should be empty")
    }
    
    func testSaveMapMarkers_multipleMarkers_nothingHappens() {
        let markers = [MapTestConstants.markerOne, MapTestConstants.markerTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository.createEmptyRepo(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        store.saveMapMarkers(mapMarkers: markers)
        XCTAssertEqual(store.getAllMapMarkers().count, 0, "Should be empty")
    }
}

// MARK: Routes
extension MapStoreTests {

    func testGetAllMapRoutes_correctRoutesReturned() {
        let mapRouteRepository = MockRouteRepository()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: mapRouteRepository,
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapRoutes(),
                                                 second: mapRouteRepository.allRoutes),
                      "Store should return same routes as repository")
    }

    func testGetAllMapRoutes_emptyRepository_noRoutesReturned() {
        let mapRouteRepository = MockRouteRepository.createEmptyRepo()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: mapRouteRepository,
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        XCTAssertTrue(store.getAllMapRoutes().isEmpty,
                      "Store should return same routes as repository")
    }

    func testSaveMapRoutes_oneRoute_nothingHappens() {
        let routeToAdd = MapTestConstants.routeOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository.createEmptyRepo(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        store.saveMapRoutes(mapRoutes: [routeToAdd])
    }

    func testSaveMapRoutes_multipleRoutes_nothingHappens() {
        let routes = [MapTestConstants.routeOne, MapTestConstants.routeTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository.createEmptyRepo(),
                             mapItineraryRepository: MockItineraryRepository(),
                             convertor: MapModelConvertor())
        store.saveMapRoutes(mapRoutes: routes)
        XCTAssertEqual(store.getAllMapRoutes().count, 0, "Should be empty")
    }
}

// MARK: Itineraries
extension MapStoreTests {

    func testGetAllMapItineraries_correctItinerariesReturned() {
        let itineraryRepository = MockItineraryRepository()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: itineraryRepository,
                             convertor: MapModelConvertor())
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapItineraries(),
                                                 second: itineraryRepository.allItineraries),
                      "Store should return same itineraries as repository")
    }

    func testGetAllMapItineraries_emptyRepository_noItinerariesReturned() {
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo(),
                             convertor: MapModelConvertor())
        XCTAssertTrue(store.getAllMapItineraries().isEmpty,
                      "Store should return same itineraries as repository")
    }

    func testSaveMapItineraries_oneItinerary_nothingHappens() {
        let itineraryToAdd = MapTestConstants.itineraryOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo(),
                             convertor: MapModelConvertor())
        store.saveMapItineraries(mapItineraries: [itineraryToAdd])
    }

    func testSaveMapItineraries_multipleItineraries_nothingHappens() {
        let itineraries = [MapTestConstants.itineraryOne, MapTestConstants.itineraryTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo(),
                             convertor: MapModelConvertor())
        store.saveMapItineraries(mapItineraries: itineraries)
        XCTAssertEqual(store.getAllMapItineraries().count, 0, "Should be empty")
    }
}
