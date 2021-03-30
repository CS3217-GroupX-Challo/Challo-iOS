//
//  MockBookingAPIParser.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
@testable import Challo

class MockBookingAPIParser: BookingAPIParser {

    typealias Response = MockBookingAPIResponses
    typealias JSON = NetworkManager.JSON

    override func extractBookingsJSON(response: JSON) -> [JSON] {
        Response.bookingJSONList
    }

    override func extractTrailID(json: JSON) -> UUID? {
        Response.trailIdOne
    }

    override func extractTouristID(json: JSON) -> UUID? {
        Response.touristIdOne
    }

    override func extractGuideID(json: JSON) -> UUID? {
        Response.guideIdOne
    }
    
    override func convertJSONToBooking(json: JSON, guide: Guide, trail: Trail, tourist: Tourist) -> Booking? {
        Response.bookingOne
    }
}
