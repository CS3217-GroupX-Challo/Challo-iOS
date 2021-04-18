//
//  TouristModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class TouristModelConvertorTests: XCTestCase {
    let tourist = Tourist(userId: UUID(),
                          email: "bob@gmail.com",
                          profileImg: "es.jpg",
                          name: "bob",
                          phone: "1234567",
                          dateJoined: Date(),
                          sex: Sex.Male)
    
    let convertor = TouristModelConvertor()
    
    func testConvertModelToPersistenceObject_withTourist_PersistenceObjectWithSameProperties() {
        let touristObject = convertor.convertModelToPersistenceObject(model: tourist)
        XCTAssertEqual(tourist.userId, touristObject.userId, "Should be equal")
        XCTAssertEqual(tourist.email, touristObject.email, "Should be equal")
        XCTAssertEqual(tourist.profileImg, touristObject.profileImg, "Should be equal")
        XCTAssertEqual(tourist.name, touristObject.name, "Should be equal")
        XCTAssertEqual(tourist.phone, touristObject.phone, "Should be equal")
        XCTAssertEqual(tourist.dateJoined, touristObject.dateJoined, "Should be equal")
        XCTAssertEqual(tourist.sex, touristObject.sex, "Should be equal")
    }
    
    func testConvertPersistenceObjectToModel_withTouristToAndFro_returnsSameTourist() {
        let touristObject = convertor.convertModelToPersistenceObject(model: tourist)
        let touristReturned = convertor.convertPersistenceObjectToModel(object: touristObject)
        XCTAssertEqual(tourist, touristReturned, "Should be equal")
    }
}
