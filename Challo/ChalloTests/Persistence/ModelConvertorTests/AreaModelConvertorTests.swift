//
//  AreaModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class AreaModelConvertorTests: XCTestCase {
    let area = Area(areaId: UUID(),
                    village: "Test",
                    division: "Test",
                    state: "Test srare",
                    country: "ypee")
    
    let convertor = AreaModelConvertor()
    
    func testConvertModelToPersistenceObject_withArea_returnsPersistenceObjectWithCorrectProperties() {
        let areaObject = convertor.convertModelToPersistenceObject(model: area)
        XCTAssertEqual(areaObject.areaId, area.areaId, "Should be equal")
        XCTAssertEqual(areaObject.village, area.village, "Should be equal")
        XCTAssertEqual(areaObject.division, area.division, "Should be equal")
        XCTAssertEqual(areaObject.state, area.state, "Should be equal")
        XCTAssertEqual(areaObject.country, area.country, "Should be equal")
    }
    
    func testConvertPersistenceObjectToModel_withAreaToAndFro_returnSameArea() {
        let areaObject = convertor.convertModelToPersistenceObject(model: area)
        let returnedArea = convertor.convertPersistenceObjectToModel(object: areaObject)
        XCTAssertEqual(area, returnedArea)
    }
}
