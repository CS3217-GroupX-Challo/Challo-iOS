//
//  MapRouteTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest
import MapKit

class MapRouteTests: XCTestCase {
    let mapMarker = MapMarker(id: UUID(),
                              position: CLLocationCoordinate2D(latitude: 10, longitude: 10),
                              date: Date(),
                              comments: "CS3217")
    let id1 = UUID()
    let id2 = UUID()
    let comments = "Comments"
    let date = Date()
    
    func testConstruct() {
        let mapRoute = MapRoute(id: id1,
                                start: mapMarker,
                                end: mapMarker,
                                date: date,
                                comments: comments)
        XCTAssertEqual(mapRoute.comments, comments, "Not initialized properly")
        XCTAssertEqual(mapRoute.id, id1, "Not initialized properly")
        XCTAssertEqual(mapRoute.date, date, "Not initialized properly")
        XCTAssertEqual(mapRoute.start, mapMarker, "Not initialized properly")
        XCTAssertEqual(mapRoute.end, mapMarker, "Not initialized properly")
    }
    
    func testEquatable_sameId_returnsTrue() {
        let mapRoute1 = MapRoute(id: id1,
                                 start: mapMarker,
                                 end: mapMarker,
                                 date: date,
                                 comments: comments)
        let mapRoute2 = MapRoute(id: id1,
                                 start: mapMarker,
                                 end: mapMarker,
                                 date: date,
                                 comments: comments)
        XCTAssertEqual(mapRoute1, mapRoute2, "Should be equal")
    }
    
    func testEquatable_differentId_returnsTrue() {
        let mapRoute1 = MapRoute(id: id1,
                                 start: mapMarker,
                                 end: mapMarker,
                                 date: date,
                                 comments: comments)
        let mapRoute2 = MapRoute(id: id2,
                                 start: mapMarker,
                                 end: mapMarker,
                                 date: date,
                                 comments: comments)
        XCTAssertNotEqual(mapRoute1, mapRoute2, "Should not be equal")
    }
}
