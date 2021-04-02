//
//  MapMarkerTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest
import MapKit

class MapMarkerTests: XCTestCase {
    let position = CLLocationCoordinate2D(latitude: 10,
                                          longitude: 10)
    let id1 = UUID()
    let id2 = UUID()
    let date = Date()
    let comments = "No comments"
    
    func testConstruct() {
        let mapMarker = MapMarker(id: id1,
                                  position: position,
                                  date: date,
                                  comments: comments)
        XCTAssertEqual(mapMarker.id, id1, "Not initialized properly")
        XCTAssertEqual(mapMarker.date, date, "Not initialized properly")
        XCTAssertEqual(mapMarker.comments, comments, "Not initialized properly")
        XCTAssertEqual(mapMarker.position.latitude, position.latitude, "Not initialized properly")
        XCTAssertEqual(mapMarker.position.longitude, position.longitude, "Not initialized properly")
    }
    
    func testEquatable_sameId_returnsTrue() {
        let mapMarker1 = MapMarker(id: id1,
                                   position: position,
                                   date: date,
                                   comments: comments)
        let mapMarker2 = MapMarker(id: id1,
                                   position: position,
                                   date: date,
                                   comments: comments)
        XCTAssertEqual(mapMarker1, mapMarker2, "Should be equal")
    }
    
    func testEquatable_differentId_returnsTrue() {
        let mapMarker1 = MapMarker(id: id1,
                                   position: position,
                                   date: date,
                                   comments: comments)
        let mapMarker2 = MapMarker(id: id2,
                                   position: position,
                                   date: date,
                                   comments: comments)
        XCTAssertNotEqual(mapMarker1, mapMarker2, "Should not be equal")
    }
}
