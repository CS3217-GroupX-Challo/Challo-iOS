//
//  PlaceTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest
import MapKit

class PlaceTests: XCTestCase {
    private let id1 = UUID()
    private let id2 = UUID()
    private let longitude: CLLocationDegrees = 10
    private let latitude: CLLocationDegrees = 12
    private let placeName = "Test"
    private let rating = 1.5
    private let address = "Somewhere on earth"
    
    func testConstruct() {
        let place = Place(id: id1,
                          longitude: longitude,
                          latitude: latitude,
                          name: placeName,
                          rating: rating,
                          isOpen: false,
                          address: address)
        XCTAssertEqual(place.id, id1, "Not initialized properly")
        XCTAssertEqual(place.longitude, longitude, "Not initialized properly")
        XCTAssertEqual(place.latitude, latitude, "Not initialized properly")
        XCTAssertEqual(place.name, placeName, "Not initialized properly")
        XCTAssertFalse(place.isOpen, "Not initialized properly")
        XCTAssertEqual(place.address, address, "Not initialized properly")
        XCTAssertEqual(place.rating, rating, "Not initialized properly")
    }
    
    func testEquatable_samePlace_returnsTrue() {
        let place1 = Place(id: id1,
                           longitude: longitude,
                           latitude: latitude,
                           name: placeName,
                           rating: rating,
                           isOpen: false,
                           address: address)
        let place2 = Place(id: id1,
                           longitude: longitude,
                           latitude: latitude,
                           name: placeName,
                           rating: rating,
                           isOpen: false,
                           address: address)
        XCTAssertEqual(place1, place2, "Should be equal")
    }
    
    func testEquatable_differentPlace_returnsTrue() {
        let place1 = Place(id: id1,
                           longitude: longitude,
                           latitude: latitude,
                           name: placeName,
                           rating: rating,
                           isOpen: false,
                           address: address)
        let place2 = Place(id: id2,
                           longitude: longitude,
                           latitude: latitude,
                           name: placeName,
                           rating: rating,
                           isOpen: false,
                           address: address)
        XCTAssertNotEqual(place1, place2, "Should not be equal")
    }
}
