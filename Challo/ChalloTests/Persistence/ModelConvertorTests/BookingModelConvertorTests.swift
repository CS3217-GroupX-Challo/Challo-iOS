//
//  BookingModelConvertorTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 18/4/21.
//

import Foundation
import XCTest

@testable import Challo

class BookingModelConvertorTests: XCTestCase {
    let currentBooking = MockBookingAPIResponses.bookingOne
    var convertor: BookingModelConvertor?
    
    override func setUp() {
        super.setUp()
        
        let areaModelConvertor = AreaModelConvertor()
        let touristModelConvertor = TouristModelConvertor()
        let trailModelConvertor = TrailModelConvertor(convertor: areaModelConvertor)
        let guideModelConvertor = GuideModelConvertor(areaModelConvertor: areaModelConvertor,
                                                      trailModelConvertor: trailModelConvertor)
        let reviewModelConvertor = ReviewModelConvertor(guideModelConvertor: guideModelConvertor,
                                                        touristModelConvertor: touristModelConvertor,
                                                        trailModelConvertor: trailModelConvertor)
        convertor = BookingModelConvertor(trailModelConvertor: trailModelConvertor,
                                          guideModelConvertor: guideModelConvertor,
                                          touristModelConvertor: touristModelConvertor,
                                          reviewModelConvertor: reviewModelConvertor)
    }
    
    func testConvertModelToPersistenceObject_withBooking_returnsPersistenceObjectWithCorrectProperties() {
        guard let bookingConvertor = convertor,
              let booking = currentBooking else {
            XCTFail("Should be initialized")
            return
        }
        
        let bookingObject = bookingConvertor.convertModelToPersistenceObject(model: booking)
        XCTAssertEqual(booking.bookingId, bookingObject.bookingId, "Should be equal")
        XCTAssertEqual(booking.createdAt, bookingObject.createdAt, "Should be equal")
        XCTAssertEqual(booking.date, bookingObject.date, "Should be equal")
        XCTAssertEqual(booking.fee, bookingObject.fee, "Should be equal")
        XCTAssertEqual(booking.status, bookingObject.status, "Should be equal")
    }
    
    func testConvertPersistenceObjectToModel_withBookingToAndFro_sameBooking() {
        guard let bookingConvertor = convertor,
              let booking = currentBooking else {
            XCTFail("Should be initialized")
            return
        }
        
        let bookingObject = bookingConvertor.convertModelToPersistenceObject(model: booking)
        let bookingReturned = bookingConvertor.convertPersistenceObjectToModel(object: bookingObject)
        XCTAssertEqual(booking, bookingReturned, "Should be equal")
    }
}
