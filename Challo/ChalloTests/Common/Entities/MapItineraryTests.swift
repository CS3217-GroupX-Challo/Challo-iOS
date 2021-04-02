//
//  MapItineraryTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest

class MapItineraryTests: XCTestCase {
    let id1 = UUID()
    let id2 = UUID()
    let title = "Hello"
    let createdAt = Date()
    let lastModified = Date()
    
    func testConstruct() {
        let mapItinerary = MapItinerary(id: id1,
                                        routes: [],
                                        markers: [],
                                        title: title,
                                        createdAt: createdAt,
                                        lastModified: lastModified)
        XCTAssertEqual(mapItinerary.id, id1, "Not intialized properly")
        XCTAssertEqual(mapItinerary.routes, [], "Not intialized properly")
        XCTAssertEqual(mapItinerary.markers, [], "Not intialized properly")
        XCTAssertEqual(mapItinerary.title, title, "Not intialized properly")
        XCTAssertEqual(mapItinerary.createdAt, createdAt, "Not intialized properly")
        XCTAssertEqual(mapItinerary.lastModified, lastModified, "Not intialized properly")
    }
    
    func testEquatable_sameId_returnsTrue() {
        let mapItinerary1 = MapItinerary(id: id1,
                                         routes: [],
                                         markers: [],
                                         title: title,
                                         createdAt: createdAt,
                                         lastModified: lastModified)
        let mapItinerary2 = MapItinerary(id: id1,
                                         routes: [],
                                         markers: [],
                                         title: title,
                                         createdAt: createdAt,
                                         lastModified: lastModified)
        XCTAssertEqual(mapItinerary1, mapItinerary2, "Should be equal")
    }
    
    func testEquatable_differentId_returnsTrue() {
        let mapItinerary1 = MapItinerary(id: id1,
                                         routes: [],
                                         markers: [],
                                         title: title,
                                         createdAt: createdAt,
                                         lastModified: lastModified)
        let mapItinerary2 = MapItinerary(id: id2,
                                         routes: [],
                                         markers: [],
                                         title: title,
                                         createdAt: createdAt,
                                         lastModified: lastModified)
        XCTAssertNotEqual(mapItinerary1, mapItinerary2, "Should not be equal")
    }
}
