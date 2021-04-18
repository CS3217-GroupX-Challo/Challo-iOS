//
//  GuideModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class GuideModelConvertorTests: XCTestCase {
    let guide = MockGuideAPIResponses.guideOne
    let convertor = GuideModelConvertor(areaModelConvertor: AreaModelConvertor(),
                                        trailModelConvertor: TrailModelConvertor(convertor: AreaModelConvertor()))
    
    func testConvertModelToPersistenceObject_withGuide_returnPersistenceObjectWithCorrectProperties() {
        let guideObject = convertor.convertModelToPersistenceObject(model: guide)
        XCTAssertEqual(guide.userId, guideObject.userId, "Should be equal")
        XCTAssertEqual(guide.email, guideObject.email, "Should be equal")
        XCTAssertEqual(guide.profileImg, guideObject.profileImg, "Should be equal")
        XCTAssertEqual(guide.name, guideObject.name, "Should be equal")
        XCTAssertEqual(guide.phone, guideObject.phone, "Should be equal")
        XCTAssertEqual(guide.dateJoined, guideObject.dateJoined, "Should be equal")
        XCTAssertEqual(guide.unavailableDates, guideObject.unavailableDates, "Should be equal")
        XCTAssertEqual(guide.sex, guideObject.sex, "Should be equal")
        XCTAssertEqual(guide.rating, guideObject.rating, "Should be equal")
        XCTAssertEqual(guide.yearsOfExperience, guideObject.yearsOfExperience, "Should be equal")
        XCTAssertEqual(guide.languages, guideObject.languages, "Should be equal")
        XCTAssertEqual(guide.accreditations, guideObject.accreditations, "Should be equal")
        XCTAssertEqual(guide.biography, guideObject.biography, "Should be equal")
        XCTAssertEqual(guide.hobbies, guideObject.hobbies, "Should be equal")
        XCTAssertEqual(guide.memorableExperiences, guideObject.memorableExperiences, "Should be equal")
    }
    
    func testPersistenceObjectToModel_withGuideToAndFro_returnSameGuide() {
        let guideObject = convertor.convertModelToPersistenceObject(model: guide)
        let guideReturned = convertor.convertPersistenceObjectToModel(object: guideObject)
        XCTAssertEqual(guide, guideReturned, "Should be equal")
    }
}
