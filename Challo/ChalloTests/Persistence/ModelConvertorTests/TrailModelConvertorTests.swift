//
//  TrailModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class TrailModelConvertorTests: XCTestCase {
    static let area = Area(areaId: UUID(),
                           village: "Test",
                           division: "Test",
                           state: "Test srare",
                           country: "ypee")

    let trail = Trail(trailId: UUID(), title: "trail one", description: "test",
                      rating: 1, difficulty: .Difficult, positions: [],
                      distance: 12.3, duration: 122, elevation: 12,
                      images: ["hgi"], area: TrailModelConvertorTests.area,
                      guideIds: [],
                      numOfReviews: 2, lowestFee: 122, tags: ["best"],
                      landmarks: ["sn"])
    
    let convertor = TrailModelConvertor(convertor: AreaModelConvertor())
    
    func testConvertModelToPersistenceObject_withTrail_PersistenceObjectWithSamePropertiesReturned() {
        let trailObject = convertor.convertModelToPersistenceObject(model: trail)
        XCTAssertEqual(trail.trailId, trailObject.trailId, "Should be equal")
        XCTAssertEqual(trail.title, trailObject.title, "Should be equal")
        XCTAssertEqual(trail.description, trailObject.description, "Should be equal")
        XCTAssertEqual(trail.rating, trailObject.rating, "Should be equal")
        XCTAssertEqual(trail.difficulty, trailObject.difficulty, "Should be equal")
        XCTAssertEqual(trail.positions, trailObject.positions, "Should be equal")
        XCTAssertEqual(trail.distance, trailObject.distance, "Should be equal")
        XCTAssertEqual(trail.duration, trailObject.duration, "Should be equal")
        XCTAssertEqual(trail.elevation, trailObject.elevation, "Should be equal")
        XCTAssertEqual(trail.images, trailObject.images, "Should be equal")
        XCTAssertEqual(trail.trailId, trailObject.trailId, "Should be equal")
        XCTAssertEqual(trail.numOfReviews, trailObject.numOfReviews, "Should be equal")
        XCTAssertEqual(trail.lowestFee, trailObject.lowestFee, "Should be equal")
        XCTAssertEqual(trail.tags, trailObject.tags, "Should be equal")
        XCTAssertEqual(trail.landmarks, trailObject.landmarks, "Should be equal")
    }
    
    func testConvertPersistenceObjectToModel_withTrailToAndFro_sameTrailReturned() {
        let trailObject = convertor.convertModelToPersistenceObject(model: trail)
        let trailReturned = convertor.convertPersistenceObjectToModel(object: trailObject)
        XCTAssertEqual(trail, trailReturned, "Should be equal")
    }
}
