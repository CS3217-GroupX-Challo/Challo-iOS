//
//  PlacesAPIParserTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import XCTest

class PlacesAPIParserTests: XCTestCase {
    typealias response = MockPlacesAPIResponse
    
    private let parser = PlacesAPIParser()
    
    func testConvertPlaceJSONToPlace_validJSON_returnsCorrectPlace() throws {
        let json = response.validPlacesJSON
        let place = try XCTUnwrap(parser.convertPlaceJSONToPlace(json: json), "Failed to convert")
        XCTAssertEqual(place.address, response.place.address, "Should be equal")
        XCTAssertEqual(place.rating, response.place.rating, "Should be equal")
        XCTAssertEqual(place.name, response.place.name, "Should be equal")
        XCTAssertEqual(place.isOpen, response.place.isOpen, "Should be equal")
        XCTAssertEqual(place.latitude, response.place.latitude, "Should be equal")
        XCTAssertEqual(place.longitude, response.place.longitude, "Should be equal")
    }
    
    func testConvertPlaceJSONToPlace_geometryRemoved_returnsNil() {
        let json = response.removeUserProperty(key: Key.googleGeometry, json: response.validPlacesJSON)
        XCTAssertNil(parser.convertPlaceJSONToPlace(json: json), "Should be nil")
    }
    
    func testConvertPlaceJSONToPlace_nameRemoved_returnsNil() {
        let json = response.removeUserProperty(key: Key.googleName, json: response.validPlacesJSON)
        XCTAssertNil(parser.convertPlaceJSONToPlace(json: json), "Should be nil")
    }
    
    func testConvertPlaceJSONToPlace_addressRemoved_returnsNil() {
        let json = response.removeUserProperty(key: Key.googleAddress, json: response.validPlacesJSON)
        XCTAssertNil(parser.convertPlaceJSONToPlace(json: json), "Should be nil")
    }
    
    func testConvertPlaceJSONToPlace_ratingRemoved_returnsNil() {
        let json = response.removeUserProperty(key: Key.googleRating, json: response.validPlacesJSON)
        XCTAssertNil(parser.convertPlaceJSONToPlace(json: json), "Should be nil")
    }
    
    func testParsePlaces_jsonWithOnePlace_returnsCorrectPlacesArray() {
        let places = parser.parsePlaces(response: response.validResponse)
        XCTAssertEqual(places.count, 1, "Should have only one")
        let place = places[0]
        XCTAssertEqual(place.address, response.place.address, "Should be equal")
        XCTAssertEqual(place.rating, response.place.rating, "Should be equal")
        XCTAssertEqual(place.name, response.place.name, "Should be equal")
        XCTAssertEqual(place.isOpen, response.place.isOpen, "Should be equal")
        XCTAssertEqual(place.latitude, response.place.latitude, "Should be equal")
        XCTAssertEqual(place.longitude, response.place.longitude, "Should be equal")
    }
    
    func testParsePlaces_jsonWithTwoPlaces_returnCorrectPlacesArray() {
        var jsonResponse = response.validResponse
        jsonResponse["candidates"] = [response.validPlacesJSON, response.validPlacesJSON]
        let places = parser.parsePlaces(response: jsonResponse)
        XCTAssertEqual(places.count, 2, "Should have only two")
        
        var place = places[0]
        XCTAssertEqual(place.address, response.place.address, "Should be equal")
        XCTAssertEqual(place.rating, response.place.rating, "Should be equal")
        XCTAssertEqual(place.name, response.place.name, "Should be equal")
        XCTAssertEqual(place.isOpen, response.place.isOpen, "Should be equal")
        XCTAssertEqual(place.latitude, response.place.latitude, "Should be equal")
        XCTAssertEqual(place.longitude, response.place.longitude, "Should be equal")
        
        place = places[1]
        XCTAssertEqual(place.address, response.place.address, "Should be equal")
        XCTAssertEqual(place.rating, response.place.rating, "Should be equal")
        XCTAssertEqual(place.name, response.place.name, "Should be equal")
        XCTAssertEqual(place.isOpen, response.place.isOpen, "Should be equal")
        XCTAssertEqual(place.latitude, response.place.latitude, "Should be equal")
        XCTAssertEqual(place.longitude, response.place.longitude, "Should be equal")
    }
    
    func testParsePlaces_emptyJSON_returnsEmptyArray() {
        var jsonResponse = response.validResponse
        jsonResponse["candidates"] = []
        let places = parser.parsePlaces(response: jsonResponse)
        XCTAssertTrue(places.isEmpty, "Should be empty")
    }
}
