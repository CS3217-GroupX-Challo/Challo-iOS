//
//  ItineraryMapRoutesRepositoryTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 4/4/21.
//

@testable import Challo
import MapKit
import Foundation
import XCTest

class ItineraryMapRoutesRepositoryTests: XCTestCase {

    func testGetRoutes_noRoutes_returnsEmptyList() {
        let repo = ItineraryMapRoutesRepository()
        XCTAssertTrue(repo.getRoutes().isEmpty)
    }

    func testAddRouteThenGetRoutes_addOneRoute_routeAdded() {
        let repo = ItineraryMapRoutesRepository()
        let routeToAdd = MapTestConstants.routeOne
        repo.addRoute(route: routeToAdd)
        let retrievedRoutes = repo.getRoutes()
        XCTAssertEqual(1, retrievedRoutes.count)
        XCTAssertEqual(routeToAdd, retrievedRoutes[0])
    }

    func testAddRouteThenGetRoutes_addMultipleRoute_routesAllAdded() {
        let repo = ItineraryMapRoutesRepository()
        let routesToAdd = [MapTestConstants.routeOne, MapTestConstants.routeTwo]
        routesToAdd.forEach {
            repo.addRoute(route: $0)
        }
        let retrievedRoutes = repo.getRoutes()
        XCTAssertEqual(routesToAdd.count, retrievedRoutes.count)
        routesToAdd.forEach {
            XCTAssertTrue(retrievedRoutes.contains($0))
        }
    }
}
