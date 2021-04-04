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
                             mapItineraryRepository: MockItineraryRepository())
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapMarkers(),
                                                 second: markerRepository.allMarkers),
                      "Store should return same markers as repository")
    }

    func testGetAllMapMarkers_emptyRepository_noMarkersReturned() {
        let markerRepository = MockMarkerRepository.createEmptyRepo()
        let store = MapStore(mapMarkerRepository: markerRepository,
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository())
        XCTAssertTrue(store.getAllMapMarkers().isEmpty,
                      "Store should return same markers as repository")
    }

    func testSaveMapMarkers_oneMarker_markerSuccessfullySaved() {
        let markerToSave = MapTestConstants.markerOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository.createEmptyRepo(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository())
        store.saveMapMarkers(mapMarkers: [markerToSave])
        XCTAssertTrue(store.getAllMapMarkers().contains(markerToSave),
                      "Store should contain saved marker")
    }
    
    func testSaveMapMarkers_multipleMarkers_allSaved() {
        let markers = [MapTestConstants.markerOne, MapTestConstants.markerTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository.createEmptyRepo(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository())
        store.saveMapMarkers(mapMarkers: markers)
        markers.forEach {
            XCTAssertTrue(store.getAllMapMarkers().contains($0),
                          "Store should contain saved marker")
        }
    }
}

// MARK: Routes
extension MapStoreTests {

    func testGetAllMapRoutes_correctRoutesReturned() {
        let mapRouteRepository = MockRouteRepository()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: mapRouteRepository,
                             mapItineraryRepository: MockItineraryRepository())
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapRoutes(),
                                                 second: mapRouteRepository.allRoutes),
                      "Store should return same routes as repository")
    }

    func testGetAllMapRoutes_emptyRepository_noRoutesReturned() {
        let mapRouteRepository = MockRouteRepository.createEmptyRepo()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: mapRouteRepository,
                             mapItineraryRepository: MockItineraryRepository())
        XCTAssertTrue(store.getAllMapRoutes().isEmpty,
                      "Store should return same routes as repository")
    }

    func testSaveMapRoutes_oneRoute_routeSuccessfullySaved() {
        let routeToAdd = MapTestConstants.routeOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository.createEmptyRepo(),
                             mapItineraryRepository: MockItineraryRepository())
        store.saveMapRoutes(mapRoutes: [routeToAdd])
        XCTAssertTrue(store.getAllMapRoutes().contains(routeToAdd),
                      "Store should contain saved route")
    }

    func testSaveMapRoutes_multipleRoutes_allSaved() {
        let routes = [MapTestConstants.routeOne, MapTestConstants.routeTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository.createEmptyRepo(),
                             mapItineraryRepository: MockItineraryRepository())
        store.saveMapRoutes(mapRoutes: routes)
        routes.forEach {
            XCTAssertTrue(store.getAllMapRoutes().contains($0),
                          "Store should contain saved route")
        }
    }
}

// MARK: Itineraries
extension MapStoreTests {

    func testGetAllMapItineraries_correctItinerariesReturned() {
        let itineraryRepository = MockItineraryRepository()
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: itineraryRepository)
        XCTAssertTrue(TestUtils.compareTwoArrays(first: store.getAllMapItineraries(),
                                                 second: itineraryRepository.allItineraries),
                      "Store should return same itineraries as repository")
    }

    func testGetAllMapItineraries_emptyRepository_noItinerariesReturned() {
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo())
        XCTAssertTrue(store.getAllMapItineraries().isEmpty,
                      "Store should return same itineraries as repository")
    }

    func testSaveMapItineraries_oneItinerary_itinerarySuccessfullySaved() {
        let itineraryToAdd = MapTestConstants.itineraryOne
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo())
        store.saveMapItineraries(mapItineraries: [itineraryToAdd])
        XCTAssertTrue(store.getAllMapItineraries().contains(itineraryToAdd),
                      "Store should contain saved itinerary")
    }

    func testSaveMapItineraries_multipleItineraries_allSaved() {
        let itineraries = [MapTestConstants.itineraryOne, MapTestConstants.itineraryTwo]
        let store = MapStore(mapMarkerRepository: MockMarkerRepository(),
                             mapRouteRepository: MockRouteRepository(),
                             mapItineraryRepository: MockItineraryRepository.createEmptyRepo())
        store.saveMapItineraries(mapItineraries: itineraries)
        itineraries.forEach {
            XCTAssertTrue(store.getAllMapItineraries().contains($0),
                          "Store should contain saved itinerary")
        }
    }
}
