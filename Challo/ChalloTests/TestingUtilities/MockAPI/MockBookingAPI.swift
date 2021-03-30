//
//  MockBookingAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
@testable import Challo

class MockBookingAPI: BookingAPI {

    init() {
        super.init(bookingParser: MockBookingAPIParser(),
                   networkManager: MockNetworkManager(json: NetworkManager.JSON()),
                   guideAPI: MockGuideAPI(),
                   touristAPI: MockTouristAPI(),
                   trailAPI: MockTrailAPI())
    }

    override func getBookingsForTourist(id: UUID, callback: @escaping ([Booking]) -> Void) {
        let mockBookings = MockBookingAPIResponses.bookings
        callback(mockBookings)
    }
}
